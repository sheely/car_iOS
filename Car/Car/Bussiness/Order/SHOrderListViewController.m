//
//  SHOrderListViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/16/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHOrderListViewController.h"
#import "SHOrderHeaderView.h"
#import "SHOrderItemCell.h"

@interface SHOrderListViewController ()
{
    NSArray * mList;
}
@end

@implementation SHOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
       // Do any additional setup after loading the view from its nib.
}

- (void)request
{
    [self showWaitDialogForNetWork];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"ordersquery.action");
    [post.postArgs setValue:[NSNumber numberWithInt:99] forKey:@"ordertype"];
    [post.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"pageno"];
    [post.postArgs setValue:[NSNumber numberWithFloat:20] forKey:@"pagesize"];
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"orders"];
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil
  taskDidFailed:^(SHTask *t) {
      [self dismissWaitDialog];
      
  }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mList.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray  *array = [[mList objectAtIndex:section] valueForKey:@"baojialist"];
    
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = [mList objectAtIndex:indexPath.section];
    NSArray * array  = [dic valueForKey:@"baojialist"];
    NSDictionary * dic_n = [array objectAtIndex:indexPath.row];
    
    SHOrderItemCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHOrderItemCell" owner:nil options:nil] objectAtIndex:0];
    cell.labPrice.text = [NSString stringWithFormat:@"%g元",[[dic_n valueForKey:@"discountafteronlinepay"]floatValue]];
    cell.labShopName.text = [dic_n valueForKey:@"shopname"];
    cell.labOrPrice.text= [NSString stringWithFormat:@"%g元",[[dic_n valueForKey:@"originalprice"]floatValue]];
    [cell.imgView setUrl:[dic_n valueForKey:@"shoplogo"]];
    cell.backgroundColor = [UIColor whiteColor];
    cell.btnPay.tag = indexPath.row;
    cell.index = indexPath;
    [cell.btnPay addTarget:self action:@selector(btnPay:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)btnPay:(UIButton*)b
{
    
    if([b.superview.superview isKindOfClass:[SHOrderItemCell class]]){
        NSDictionary * dic = [mList objectAtIndex:((SHOrderItemCell*)b.superview.superview).index.section];
        NSDictionary * dic_n = [[dic valueForKey:@"baojialist"] objectAtIndex:((SHOrderItemCell*)b.superview.superview).index.row ];
        NSString *appScheme = @"car";
        AlixPayOrder *order = [[AlixPayOrder alloc] init];
        order.partner = PartnerID;
        order.seller = SellerID;
        order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
        order.productName = [NSString stringWithFormat:@"%@-%@",[dic_n valueForKey:@"shopname"],@"服务费"]; ; //商品标题
        order.productDescription = [NSString stringWithFormat:@"%@-%@",[dic_n valueForKey:@"shopname"],@"服务费"]; //商品描述
        order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
        order.notifyURL =  @"http://www.baidu.com"; //回调URL

        NSString* orderInfo = [order description];
        NSString* signedStr = [self doRsa:orderInfo];
        NSLog(@"%@",signedStr);
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                 orderInfo, signedStr, @"RSA"];
        [AlixLibService payOrder:orderString AndScheme:appScheme seletor: @selector(paymentResult:)
                          target:self];

    }
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary * dic = [mList objectAtIndex:section];
    SHOrderHeaderView * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHOrderHeaderView" owner:nil options:nil] objectAtIndex:0];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.imgHead setUrl:[dic valueForKey:@"servicecategorylogo"]];
    cell.labTitle.text = [dic valueForKey:@"servicecategoryname"];
    cell.labCarId.text = [dic valueForKey:@"carno"];
    cell.labState.text = @"待付款";
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}




- (NSString *)generateTradeNO
{
    const int N = 15;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand(time(0));
    for (int i = 0; i < N; i++){
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    if (result){
        if (result.statusCode == 9000){
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString]){
                //验证签名成功，交易结果无篡改
                [self showAlertDialog:@"支付成功."];
                [self request];
            }
        }
        else{
            //交易失败
            [self showAlertDialog:@"交易失败."];
        }
    }
    else{
        //失败
        [self showAlertDialog:@"交易失败."];
        
    }
    
}
@end
