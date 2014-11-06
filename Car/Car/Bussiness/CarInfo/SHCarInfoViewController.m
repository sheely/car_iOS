//
//  SHCarInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarInfoViewController.h"
#import "SHCarItemCollectionViewCell.h"
#import "SHCarInfoReportCell.h"

@interface SHCarInfoViewController ()
{
    CGRect orFrame;
    UIView * viewOrCategory;
    UIButton * lastTouchButton;
}
@end

@implementation SHCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车况档案";
    [self.collectView registerNib: [UINib nibWithNibName:@"SHCarItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"car_item_collect"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" target:self action:@selector(btnShare:)];
    self.imgIndicator.layer.anchorPoint = CGPointMake(0.88, 0.5);

    [self performSelector:@selector(drawdashboard) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(viewAnimation) withObject:nil afterDelay:0.5];
    // Do any additional setup after loading the view from its nib.
}

int sum = 30;
int cur = 0;
int order = 0;

- (void)viewAnimation
{
    [UIView animateWithDuration:1 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.viewOil.frame;
        frame.origin.x += 55;
        frame.origin.y += 55;
        self.viewOil.frame = frame;
        self.viewOil.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.viewPower.frame;
        frame.origin.x -= 55;
        frame.origin.y -= 55;
        self.viewPower.frame = frame;
        self.viewPower.alpha = 1;
    } completion:nil];
     
    
    [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.viewSafety.frame;
        frame.origin.x += 55;
        frame.origin.y -= 55;
        self.viewSafety.frame = frame;
        self.viewSafety.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame =  self.viewCarControl.frame;
        frame.origin.x -= 55;
        frame.origin.y += 55;
        self.viewCarControl.frame = frame;
        self.viewCarControl.alpha = 1;
    } completion:nil];

}

- (void)drawdashboard
{
    float persent =  255.0/100;
    float persentg = 173.0/100;
    float persentb = 163.0/100;
    float persentIndicator = (3.14 +1.4)/100;
    self.viewDashBoard.backgroundColor =  [UIColor colorWithRed:(255 - persent*cur )/255.0 green:(persentg*cur )/255.0  blue: (persentb*cur )/255.0 alpha:1];
    self.labScore.textColor = [UIColor colorWithRed:(255 - persent*cur )/255.0 green:(persentg*cur )/255.0  blue: (persentb*cur )/255.0 alpha:1];
    self.imgIndicator.transform = CGAffineTransformMakeRotation(persentIndicator* cur - 0.7);
    self.labScore.text = [NSString stringWithFormat:@"%d分",cur];
    if(cur < 100 && order == 0){
        [self performSelector:@selector(drawdashboard) withObject:nil afterDelay:0.008];
        cur ++ ;
    }else{
        order = 1;
        if(order == 1 && cur > sum){
            [self performSelector:@selector(drawdashboard) withObject:nil afterDelay:0.008];
            cur -- ;
        }
    }
    
}

- (void)btnShare:(NSObject*)object
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                }
                            }];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHCarItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"car_item_collect" forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.labTitle.text = @"刹车片";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_breaking"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_warning"];
    }else if (indexPath.row == 1){
        cell.labTitle.text = @"机油";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_gas"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_fault"];
    }else{
        cell.labTitle.text = @"变速箱";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_set"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_normal"];
    }
    cell.btnItem.tag = indexPath.row;
    [cell.btnItem addTarget:self action:@selector(btnItemOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnItem.tag = indexPath.row;
    return cell;
}

- (void)btnItemOnTouch:(UIButton*)button
{
    //KxMenu * kx = [[KxMenu alloc]init];
    KxMenuItem * kxt = [[KxMenuItem alloc]init];
    kxt.title = @"变更:正常";
    kxt.target = self;
    kxt.action = @selector(kxtOnTouch:);
    kxt.tag = button.tag;
    kxt.image = [UIImage imageNamed:@"set_status_normal"];
    kxt.index = 0;
    KxMenuItem * kxt2 = [[KxMenuItem alloc]init];
    kxt2.title = @"变更:需注意";
    kxt2.target = self;
    kxt2.action = @selector(kxtOnTouch:);
    kxt2.tag = button.tag;
    kxt2.index = 1;
    kxt2.image = [UIImage imageNamed:@"set_status_fault"];

    KxMenuItem * kxt3 = [[KxMenuItem alloc]init];
    kxt3.title = @"变更:有问题";
    kxt3.target = self;
    kxt3.action = @selector(kxtOnTouch:);
    kxt3.tag = button.tag;
    kxt3.index = 2;
    kxt3.image = [UIImage imageNamed:@"set_status_warning"];

    KxMenuItem * kxt4 = [[KxMenuItem alloc]init];

    kxt4.title = @"查看检测报告";
    kxt4.target = self;
    kxt4.action = @selector(kxtOnTouch:);
    kxt4.tag = button.tag;
    kxt4.index = 3;
    kxt4.image = [UIImage imageNamed:@"lis_icon_report"];

    [KxMenu showMenuInView:self.view fromRect:[button convertRect:button.frame toView:self.view] menuItems:@[kxt,kxt2,kxt3,kxt4]];
}

- (void)kxtOnTouch:(KxMenuItem*)item
{
    if(item.index == 3){
        SHIntent * i = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
        [[UIApplication sharedApplication]open:i];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnCheck.layer.cornerRadius = 3;
    self.btnCheck.layer.masksToBounds = YES;
    self.btnCarState.layer.cornerRadius = 3;
    self.btnCarState.layer.masksToBounds = YES;
    self.btnNotification.layer.cornerRadius = 3;
    self.btnNotification.layer.masksToBounds = YES;
    self.btnRepair.layer.cornerRadius = 3;
    self.btnRepair.layer.masksToBounds = YES;
    self.collectView.layer.borderWidth = 0.5;
    self.collectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view4Itmes.layer.borderWidth = 0.5;
    self.view4Itmes.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        SHIntent * i = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
        [[UIApplication sharedApplication]open:i];
    }else if (indexPath.row == 1){
        SHIntent * i = [[SHIntent alloc]init:@"insurancereport" delegate:nil containner:self.navigationController];
        [[UIApplication sharedApplication]open:i];

    }else if (indexPath.row == 3 ){
        SHIntent * i = [[SHIntent alloc]init:@"contentcontainer" delegate:nil containner:self.navigationController];
        [i.args setValue:@"车况变化报告" forKey:@"title"];
        [i.args setValue:@"您手动将 [刹车片]状态由 \"不正常\"改变为\"完好\"\n您手动将 [反光镜]状态由 \"不正常\"改变为\"完好\"\n您手动将 [胎压]状态由 \"不正常\"改变为\"完好\"\n您手动将 刹车片状态由 \"不正常\"改变为\"完好\"\n您手动将 刹车片状态由 \"不正常\"改变为\"完好\"\n  2014- 10 -15" forKey:@"content"];
        
        [[UIApplication sharedApplication]open:i];
    }else if (indexPath.row == 2 ){
        SHIntent * i = [[SHIntent alloc]init:@"contentcontainer" delegate:nil containner:self.navigationController];
        [i.args setValue:@"车况变化报告" forKey:@"title"];
        [i.args setValue:@"亲爱的客户，您的车辆已经保养维修完毕，本次保养维修，我们帮您\n更换机油滤清器“一个”，价格:“780元”\n更换刹车片“一个”，价格“1290元”\n谢谢您的使用,祝您驾车愉快." forKey:@"content"];
        
        [[UIApplication sharedApplication]open:i];
    }
    
}

- (IBAction)btnOilOnTouch:(UIButton*)sender {
    if(viewOrCategory == nil){
        viewOrCategory = sender.superview;
        orFrame = viewOrCategory.frame;
        
        [UIView animateWithDuration:1 animations:^{
            self.collectView.alpha = 1;
            self.viewCarControl.alpha = 0;
            self.viewPower.alpha = 0;
            self.viewSafety.alpha = 0;
            self.viewOil.alpha = 0;
            viewOrCategory.alpha = 1;
            self.imgCar.alpha = 0;
            CGRect  frame  = viewOrCategory.frame;
            frame.origin.y = 5;
            frame.origin.x = 14;
            viewOrCategory.frame = frame;
            self.imgBgBlue.alpha = 0;
        } completion:^(BOOL flag){
            self.imgBgBlue.hidden = YES;
        }];
    }else{
        self.imgBgBlue.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            viewOrCategory.frame = orFrame;
            self.imgBgBlue.alpha = 1;
            self.collectView.alpha = 0;
            self.viewCarControl.alpha = 1;
            self.viewPower.alpha = 1;
            self.viewSafety.alpha = 1;
            self.viewOil.alpha = 1;
            self.imgCar.alpha = 1;
        } completion:^(BOOL f){
            viewOrCategory = nil;
            f = YES;
        }];

    }
}
- (IBAction)btnBackOnTouch:(id)sender {
}

- (IBAction)btnCheckOnTouch:(id)sender
{
    SHIntent * i = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
    [i.args setValue:@"dsfsdfsdsfd" forKey:@"reportid"];

    [[UIApplication sharedApplication]open:i];
}
@end
