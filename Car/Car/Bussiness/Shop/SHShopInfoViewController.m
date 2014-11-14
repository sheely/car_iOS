//
//  SHShopInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/25/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopInfoViewController.h"
#import "SHCleanViewCell.h"

@interface SHShopInfoViewController ()
{
    NSDictionary * dic;
    NSString * orderId;
}
@end

@implementation SHShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户详情";
    [self request];
    // Do any additional setup after loading the view from its nib.
}

- (void)request
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"shopdetail.action");
    [post.postArgs setValue:[self.intent.args valueForKey:@"shopid"] forKey:@"shopid"];
    [post start:^(SHTask *t) {
        dic = (NSDictionary*)t.result;
        self.labName.text = [dic valueForKey:@"shopname"];
        self.labAddress.text = [dic valueForKey:@"shopaddress"];
        self.labScore.text = [NSString stringWithFormat:@"%@ 分",[[dic valueForKey:@"shopscore"] stringValue]];
        [self.imgHead setUrl:[dic valueForKey:@"shoplogo"]];
        int score = [[dic valueForKey:@"shopscore"] integerValue];
        switch (score) {
                
            case 5:
                self.img5.image = [SHSkin.instance image:@"star_selected.png"];
            case 4:
                self.img4.image = [SHSkin.instance image:@"star_selected.png"];
            case 3:
                self.img3.image = [SHSkin.instance image:@"star_selected.png"];
            case 2:
                self.img2.image = [SHSkin.instance image:@"star_selected.png"];
            case 1:
                self.img1.image = [SHSkin.instance image:@"star_selected.png"];
                break;
                
            default:
                break;
        }
        
        
        [self dismissWaitDialog];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];
}

- (void)loadSkin
{
    [super loadSkin];
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCleanViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCleanViewCell" owner:nil options:nil]objectAtIndex:0];
    cell.dicInfo = dic;
    [cell.btnSubmit addTarget:self action:@selector(btnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)btnSubmit:(UIButton *)b
{

    [self showWaitDialog:@"正在创建订单..." state:@"请稍候"];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"washordercreate.action");
    SHCleanViewCell * cell = (SHCleanViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [post.postArgs setValue:[self.intent.args valueForKey:@"shopid"] forKey:@"shopid"];
    if(cell.btnNormal.selected){
        [post.postArgs setValue:[NSNumber numberWithInt:0 ] forKey:@"washtype"];
    }else{
        [post.postArgs setValue:[NSNumber numberWithInt:1 ] forKey:@"washtype"];
    }
    if(cell.btnExtra.selected){
        [post.postArgs setValue:cell.gouponId forKey:@"ticketid"];

    }else{
        [post.postArgs setValue:@"" forKey:@"ticketid"];

    }
    
    
    
    [post start:^(SHTask *t) {
        if([t.result valueForKey:@"orderid"]){
            orderId = [t.result valueForKey:@"orderid"];
            [self showAlertDialog:[NSString stringWithFormat: @"请在与商家的交易结束付款。\n现在确认付款［%d］元?",[[t.result valueForKey:@"finalprice"] integerValue]] button:@"确定" otherButton:@"取消"];
        }
        
        [self dismissWaitDialog];

    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];

}

- (void)alertViewEnSureOnClick
{
    NSString *appScheme = @"car";
    
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO =  orderId ; //订单ID（由商家自行制定）
    order.productName = @"洗车"; //商品标题
    order.productDescription = [NSString stringWithFormat:@"%@-服务费",[dic valueForKey:@"shopname"]]; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"http://112.124.22.156:8083/chebaobao/notify_url.jsp"; //回调URL
    
    NSString* orderInfo = [order description];
    
    NSString* signedStr = [self doRsa:orderInfo];
    NSLog(@"%@",signedStr);
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor: @selector(paymentResult:)
                      target:self];
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
- (IBAction)btnContact:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%d",[[dic valueForKey:@"shopmobile"] integerValue]]]];

}


- (NSString *)generateTradeNO
{
    const int N = 15;
    
    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *result = [[NSMutableString alloc] init] ;
    srand(time(0));
    for (int i = 0; i < N; i++)
    {
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

@end
