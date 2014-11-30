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
    //UIView * viewOrCategory;
    UIButton * lastTouchButton;
    NSArray * mCurrentCategory;
    NSArray * mListFourCategory;
    NSDictionary * mDic;
    BOOL isFirst;
}
@end

@implementation SHCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车况档案";
    isFirst = YES;
    [self.collectView registerNib: [UINib nibWithNibName:@"SHCarItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"car_item_collect"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" target:self action:@selector(btnShare:)];
    self.imgIndicator.layer.anchorPoint = CGPointMake(0.88, 0.5);
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_car"];
    if(dic){
        self.labBand.text = [NSString stringWithFormat:@"%@-%@",[dic valueForKey:@"carcategoryname"],[dic valueForKey:@"carseriesname"]];
        self.labCarId.text =[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"provincename"],[dic valueForKey:@"carcardno"]];
        self.imgCarLogo.isAutoAdapter = YES;
        [self.imgCarLogo setUrl:[dic valueForKey:@"carlogo"]];
    }
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request) name:@"car_changed" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self request];
}

- (void)request
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * p = [[SHPostTaskM alloc]init ];
    p.URL= URL_FOR(@"dashboard.action");
    [p start:^(SHTask *t) {
        [self dismissWaitDialog];
        mDic =(NSDictionary*) t.result;
        if([t.result valueForKey:@"activitedcar"]){
            NSDictionary* dic = [t.result valueForKey:@"activitedcar"];
            self.labBand.text = [NSString stringWithFormat:@"%@-%@",[dic valueForKey:@"carcategoryname"],[dic valueForKey:@"carseriesname"]];
            self.imgCarLogo.isAutoAdapter = YES;
            [self.imgCarLogo setUrl:[dic valueForKey:@"carlogo"]];
            self.labCarId.text = [NSString stringWithFormat:@"%@%@%@",[dic valueForKey:@"provincename"],[dic valueForKey:@"alphabetname"],[dic valueForKey:@"carcardno"]];
            sum = [[t.result valueForKey:@"totalscore"] intValue];
            [self performSelector:@selector(drawdashboard) withObject:nil afterDelay:0.5];
            [self performSelector:@selector(viewAnimation) withObject:nil afterDelay:0.5];
            mListFourCategory = [t.result valueForKey:@"fourcategory"];
            self.labState1.text = [[mListFourCategory objectAtIndex:0] valueForKey:@"healthstatus"];
            self.labState2.text = [[mListFourCategory objectAtIndex:1] valueForKey:@"healthstatus"];
            self.labState3.text = [[mListFourCategory objectAtIndex:2] valueForKey:@"healthstatus"];
            self.labState4.text = [[mListFourCategory objectAtIndex:3] valueForKey:@"healthstatus"];
            if(isFirst && [[[mDic valueForKey:@"activitedcar"] valueForKey:@"reportid"]isEqualToString:@"demo"]){
                self.viewNeedCheck.alpha = 0;
                
                [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.viewNeedCheck.alpha = 1;
                    self.viewNeedCheck.frame = [UIApplication sharedApplication].keyWindow.bounds;
                    [[UIApplication sharedApplication].keyWindow addSubview:self.viewNeedCheck];
                } completion:^(BOOL finished) {
                    
                }
                 ];
            }else{
                [self.viewNeedCheck removeFromSuperview];
            }
        }
    } taskWillTry:nil
taskDidFailed:^(SHTask *t) {
    [t.respinfo show];
    [self dismissWaitDialog];
    
}];
    
}

- (void) demo
{
    self.btnGesture.hidden = NO;
    self.btnGesture.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.btnGesture.alpha = 1;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.btnGesture.alpha = 0;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.btnGesture.alpha = 1;
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    CGRect frame = self.btnGesture.frame;
                    frame.origin.x = self.viewPower.frame.origin.x + 10;
                    frame.origin.y = self.viewPower.frame.origin.y + 10;
                    self.btnGesture.frame = frame;
                    
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.btnGesture.alpha = 0;
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.btnGesture.alpha = 1;
                            
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                self.btnGesture.alpha = 0;
                                
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                    self.btnGesture.alpha = 1;
                                    
                                } completion:^(BOOL finished) {
                                    [self btnOilOnTouch:self.btnPower];
                                    [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                        CGRect frame = self.btnGesture.frame;
                                        frame.origin.x = self.btnBack.frame.origin.x + 10;
                                        frame.origin.y = self.btnBack.frame.origin.y + 10;
                                        self.btnGesture.frame = frame;
                                        
                                    } completion:^(BOOL finished) {
                                        
                                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                            self.btnGesture.alpha = 0;
                                            
                                        } completion:^(BOOL finished) {
                                            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                self.btnGesture.alpha = 1;
                                                
                                            } completion:^(BOOL finished) {
                                                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                    self.btnGesture.alpha = 0;
                                                    
                                                } completion:^(BOOL finished) {
                                                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                                        self.btnGesture.alpha = 1;
                                                        
                                                    } completion:^(BOOL finished) {
                                                        [self btnBackOnTouch:self.btnBack];
                                                        self.btnGesture.hidden = YES;
                                                    }];
                                                }];
                                            }];
                                        }];
                                        
                                    }];
                                    
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
        
    }];
    
}

int sum = 0;
int cur = 0;
int order = 0;

- (void)viewAnimation
{
    if(!isFirst){
        return;
    }
    isFirst = NO;

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
-(UIImage*)screenShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 480), YES, 2);
    
    //设置截屏大小
    
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width,100);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return viewImage;
    //以下为图片保存代码
    
}
- (void)btnShare:(NSObject*)object
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"我的车辆"
                                       defaultContent:@"分享到我的车况信息"
                                                image:[ShareSDK pngImageWithImage:[self screenShot]]
                                                title:@"车况信息"
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
    return mCurrentCategory.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHCarItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"car_item_collect" forIndexPath:indexPath];
    NSDictionary * dic = [mCurrentCategory objectAtIndex:indexPath.row];
    
    cell.labTitle.text = [dic valueForKey:@"devicename"];
    [cell.imgView setUrl:[dic valueForKey:@"deviceslogo"]];
    if([[dic valueForKey:@"devicestatus"]integerValue] == 0){
        cell.imgState.image =  [UIImage imageNamed:@"set_status_normal"];
        
    }else  if([[dic valueForKey:@"devicestatus"]integerValue] == 1){
        cell.imgState.image =  [UIImage imageNamed:@"set_status_fault"];
        
    }else  if([[dic valueForKey:@"devicestatus"]integerValue] == 2){
        cell.imgState.image =  [UIImage imageNamed:@"set_status_warning"];
        
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
    KxMenuItem * kxt4 = [[KxMenuItem alloc]init];
    
    kxt4.title = @"检测报告";
    kxt4.target = self;
    kxt4.action = @selector(kxtOnTouch:);
    kxt4.tag = button.tag;
    kxt4.index = 1;
    kxt4.image = [UIImage imageNamed:@"lis_icon_report"];
    
    [KxMenu showMenuInView:self.view fromRect:[button convertRect:button.frame toView:self.view] menuItems:@[kxt,kxt4]];
}

- (void)kxtOnTouch:(KxMenuItem*)item
{
    if(item.index == 1){
        SHIntent * i = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
        [[UIApplication sharedApplication]open:i];
        
    }else{
        //        [self showAlertDialog:@"演示数据,不可修改"];
        NSDictionary * dic = [mCurrentCategory objectAtIndex:item.tag];
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL= URL_FOR(@"manualmodifydevice.action");
        [post.postArgs setValue:[[ mDic valueForKey:@"activitedcar"]valueForKey:@"carid"] forKey:@"carid"];
        [post.postArgs setValue:[dic valueForKey:@"deviceid"] forKey:@"deviceid"];
        [post.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"devicestatus"];
        [post start:^(SHTask *t) {
            [t.respinfo show];
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnCarState.layer.cornerRadius = 3;
    self.btnCarState.layer.masksToBounds = YES;
    self.btnNotification.layer.cornerRadius = 3;
    self.btnNotification.layer.masksToBounds = YES;
    self.btnRepair.layer.cornerRadius = 3;
    self.btnRepair.layer.masksToBounds = YES;
    self.imgCarLogo.layer.cornerRadius = 5;
    self.imgCarLogo.layer.masksToBounds = YES;
    self.collectView.layer.borderWidth = 0.5;
    self.collectView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view4Itmes.layer.borderWidth = 0.5;
    self.view4Itmes.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.row == 0){
//        SHIntent * i = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
//        [[UIApplication sharedApplication]open:i];
//    }else if (indexPath.row == 1){
//        SHIntent * i = [[SHIntent alloc]init:@"insurancereport" delegate:nil containner:self.navigationController];
//        [[UIApplication sharedApplication]open:i];
//
//    }else if (indexPath.row == 3 ){
//        SHIntent * i = [[SHIntent alloc]init:@"contentcontainer" delegate:nil containner:self.navigationController];
//        [i.args setValue:@"车况变化报告" forKey:@"title"];
//        [i.args setValue:@"您手动将 [刹车片]状态由 \"不正常\"改变为\"完好\"\n您手动将 [反光镜]状态由 \"不正常\"改变为\"完好\"\n您手动将 [胎压]状态由 \"不正常\"改变为\"完好\"\n您手动将 刹车片状态由 \"不正常\"改变为\"完好\"\n您手动将 刹车片状态由 \"不正常\"改变为\"完好\"\n  2014- 10 -15" forKey:@"content"];
//
//        [[UIApplication sharedApplication]open:i];
//    }else if (indexPath.row == 2 ){
//        SHIntent * i = [[SHIntent alloc]init:@"contentcontainer" delegate:nil containner:self.navigationController];
//        [i.args setValue:@"车况变化报告" forKey:@"title"];
//        [i.args setValue:@"亲爱的客户，您的车辆已经保养维修完毕，本次保养维修，我们帮您\n更换机油滤清器“一个”，价格:“780元”\n更换刹车片“一个”，价格“1290元”\n谢谢您的使用,祝您驾车愉快." forKey:@"content"];
//
//        [[UIApplication sharedApplication]open:i];
//    }
//
//}

- (IBAction)btnOilOnTouch:(UIButton*)sender {
    if(lastTouchButton == nil){
        mCurrentCategory = [[mListFourCategory objectAtIndex:sender.tag] valueForKey:@"deviceentities"];
        [self.collectView reloadData];
        UIView *viewOrCategory = sender.superview;
        orFrame = viewOrCategory.frame;
        lastTouchButton = sender;
        [UIView animateWithDuration:1 animations:^{
            self.collectView.alpha = 1;
            self.viewCarControl.alpha = 0;
            self.viewPower.alpha = 0;
            self.viewSafety.alpha = 0;
            self.viewOil.alpha = 0;
            viewOrCategory.alpha = 1;
            self.imgCar.alpha = 0;
            [sender setImage:nil forState:UIControlStateNormal];
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
            lastTouchButton.superview.frame = orFrame;
            [lastTouchButton setImage:[UIImage imageNamed:@"bg_popup.png"] forState:UIControlStateNormal];
            self.imgBgBlue.alpha = 1;
            self.collectView.alpha = 0;
            self.viewCarControl.alpha = 1;
            self.viewPower.alpha = 1;
            self.viewSafety.alpha = 1;
            self.viewOil.alpha = 1;
            self.imgCar.alpha = 1;
        } completion:^(BOOL f){
            lastTouchButton = nil;
            f = YES;
        }];
        
    }
}
- (IBAction)btnBackOnTouch:(id)sender {
    if(lastTouchButton != nil){
        [self btnOilOnTouch:lastTouchButton];
    }
}

- (IBAction)btnCheckOnTouch:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.viewNeedCheck.alpha = 0;
    } completion:^(BOOL finished) {
        [self.viewNeedCheck removeFromSuperview];
    }];
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"上门检测" forKey:@"title"];
    [intent.args setValue:@"check" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}


- (IBAction)btnCheckReportOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"checkreport" delegate:nil containner:self.navigationController];
    NSArray * array = [mDic valueForKey:@"reports"];
    for (int i = 0 ; i< array.count; i++) {
        NSDictionary * dic = [array objectAtIndex:i];
        if([[dic valueForKey:@"reporttype"]  integerValue] == 0){
            [intent.args setValue:[dic valueForKey:@"reportid"]  forKey:@"reportid"];
            [[UIApplication sharedApplication]open:intent];
            return;
        }
    }
    [self showAlertDialog:@"暂无车辆检测报告"];
    
}

- (IBAction)btnContinueDemoOnTouch:(id)sender {
    [UIView animateWithDuration:1 animations:^{
        self.viewNeedCheck.alpha = 0;
    } completion:^(BOOL finished) {
        [self.viewNeedCheck removeFromSuperview];
        [self demo];
    }];
}

- (IBAction)btnNodificationOnTouch:(id)sender {
    
    SHIntent * intent = [[SHIntent alloc]init:@"insurancereport" delegate:nil containner:self.navigationController];
    NSArray * array = [mDic valueForKey:@"reports"];
    for (int i = 0 ; i< array.count; i++) {
        NSDictionary * dic = [array objectAtIndex:i];
        if([[dic valueForKey:@"reporttype"]  integerValue] == 2){
            [intent.args setValue:[dic valueForKey:@"reportid"]  forKey:@"reportid"];
            [[UIApplication sharedApplication]open:intent];
            return;
        }
    }
    [self showAlertDialog:@"暂无提醒项目"];
}

- (IBAction)btnCarStateOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"car_state_changed_report" delegate:nil containner:self.navigationController];
    NSArray * array = [mDic valueForKey:@"reports"];
    for (int i = 0 ; i< array.count; i++) {
        NSDictionary * dic = [array objectAtIndex:i];
        if([[dic valueForKey:@"reporttype"]  integerValue] == 3){
            [intent.args setValue:[dic valueForKey:@"reportid"]  forKey:@"reportid"];
            [[UIApplication sharedApplication]open:intent];
            return;
        }
    }
    [self showAlertDialog:@"暂无车辆状态变化报告"];
}

- (IBAction)btnRepairOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"repair_report" delegate:nil containner:self.navigationController];
    NSArray * array = [mDic valueForKey:@"reports"];
    for (int i = 0 ; i< array.count; i++) {
        NSDictionary * dic = [array objectAtIndex:i];
        if([[dic valueForKey:@"reporttype"]  integerValue] == 1){
            [intent.args setValue:[dic valueForKey:@"reportid"]  forKey:@"reportid"];
            [[UIApplication sharedApplication]open:intent];
            return;
        }
    }
    [self showAlertDialog:@"暂无车辆维修报告"];
}


@end
