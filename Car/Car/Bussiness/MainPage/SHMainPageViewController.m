//
//  SHMainPageViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMainPageViewController.h"
#import "SHChatListHelper.h"
#import <SHCore/SHHttpReel.h>
@interface SHMainPageViewController ()
{
    NSTimer * timer;
    int index;
    int direct;
    BOOL isGuild;
}
@end

@implementation SHMainPageViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"view_mainpage"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车宝宝";
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width * 3, scrollview.frame.size.height);
    timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(btnChanged:) userInfo:nil repeats:YES];
    NSDictionary * dicuser = [[NSUserDefaults standardUserDefaults] valueForKey: STORE_USER_INFO];
    if(dicuser){
        SHEntironment.instance.loginName = [dicuser valueForKey:@"username"];
        SHEntironment.instance.password = [dicuser valueForKey:@"password"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configChanged:) name:CORE_NOTIFICATION_CONFIG_STATUS_CHANGED object:nil];
    [[SHConfigManager instance] setURL:URL_FOR( @"getconfig.action")];
    [[SHConfigManager instance] refresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(require_update:) name:NOTIFICATION_UPDATE_REQUIRE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSussessful:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChanged:) name:@"newmessage" object:nil];
    //[self requestChatList];
    [self loginSussessful:nil];
    //    pagecontrol
    // Do any additional setup after loading the view from its nib.
}

- (void)configChanged:(NSObject*)b

{
    [[SHConfigManager instance] show];
}

- (void)messageChanged:(NSNotification*)n
{
    NSArray * array = [((SHResMsgM*)n.object).result valueForKey:@"ordernewmessage"];
    for (NSDictionary * dic  in array) {
        NSString * orderid = [dic valueForKey:@"orderid"];
        NSArray * mList = [dic valueForKey:@"leavemessages"];
        for (NSDictionary * dic2  in mList) {
            SHChatItem * item = [[SHChatItem alloc]init];
  
            item.asktime = [dic2 valueForKey:@"leavemessagetime"];
            item.latestmessage = [dic2 valueForKey:@"leavemessagecontent"];
            if([[dic2 valueForKey:@"leavemessagetype"]integerValue ]== 1){
                item.latestmessage = @"[图片]";
            }else if ([[dic2 valueForKey:@"leavemessagetype" ]integerValue ] == 2){
                item.latestmessage = @"[声音]";
            }
            item.questionid = orderid;
            [SHChatListHelper.instance addItem:item];
        }

    }
    [SHChatListHelper.instance notice];

}

- (void)loginSussessful:(NSNotification*)n
{
    if(SHEntironment.instance.loginName.length > 0){
        SHHttpReel * reel = [[SHHttpReel alloc]init];
        reel.URL = URL_FOR(@"eachnotify.action");
        SHMsgManager.instance.reel = reel;
        [self requestChatList];
    }
}
- (void)require_update:(NSNotification*)n
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_remain" object:@"order"];

    [self requestChatList];
}
- (void)requestChatList
{
    //[self showWaitDialogForNetWork];
    if(SHEntironment.instance.loginName.length > 0){
        [SHChatListHelper.instance removeAll];
        SHPostTaskM * task = [[SHPostTaskM alloc]init];
        task.URL= URL_FOR(@"acceptquestionlist.action");
        [task.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"pageno"];
        [task.postArgs setValue:[NSNumber numberWithInt:400] forKey:@"pagesize"];
        [task start:^(SHTask *t) {
            NSArray * mList = [t.result valueForKey:@"questions"];
            for (NSDictionary * dic  in mList) {
                SHChatItem * item = [[SHChatItem alloc]init];
                
                NSString*desc = [dic valueForKey:@"problemdesc"];
              
                NSRange  r = [desc rangeOfString:@"("];
                if(r.location  != NSIntegerMax){
                     desc = [desc substringToIndex:r.location];
                }
                item.problemdesc =[ NSString stringWithFormat:@"%@(%@)",desc,[dic valueForKey:@"carcardno"]];
                item.asktime = [dic valueForKey:@"asktime"];
                item.uploadpicture = [dic valueForKey:@"uploadpicture"];
                item.latestmessage = [dic valueForKey:@"latestmessage"];
                //item.problemdesc = [dic valueForKey:@"problemdesc"];
                item.questionid = [dic valueForKey:@"questionid"];
                [SHChatListHelper.instance addItem:item];
            }
            [SHChatListHelper.instance notice];
            [self dismissWaitDialog];
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
            [self dismissWaitDialog];
        }];

    }
   
}

- (void)btnChanged:(NSObject*)nssender
{
    if(direct){
        index--;
    }else{
        index++;
    }
    if(index == 2){
        direct = 1;
    }else if (index==0){
        direct = 0;
    }
    [scrollview setContentOffset:CGPointMake(index*self.view.frame.size.width, 0) animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_car"];
    if(dic){
        labBrand.text = [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"carcategoryname"],[dic valueForKey:@"carseriesname"]];
        labCardNo.text =[NSString stringWithFormat:@"%@%@ %@",[dic valueForKey:@"provincename"],[dic valueForKey:@"alphabetname"],[dic valueForKey:@"carcardno"]];
        [imgBrand setUrl:[dic valueForKey:@"carlogo"]];
        
    }else{
        if(!isGuild){
            isGuild = YES;
        viewguild.alpha = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:viewguild];
        
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            viewguild.alpha = 1;
        } completion:^(BOOL finished) {
        }];
        }
    }
    [MobClick beginLogPageView:@"view_mainpage"];

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

- (IBAction)btnSupportOnTouch:(id)sender
{
    [self performSelector:@selector(notificationSupport) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationSupport
{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"紧急援助" forKey:@"title"];
    [intent.args setValue:@"support" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnRepair:(id)sender {
    [self performSelector:@selector(notificationRepair) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationRepair{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"保养" forKey:@"title"];
    [intent.args setValue:@"repair" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}


- (IBAction)btnInsuranceOnTouch:(id)sender {
    [self performSelector:@selector(notificationInsurance) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationInsurance
{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"代办业务" forKey:@"title"];
    [intent.args setValue:@"insurance" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnMoreOnTouch:(id)sender {
    [self performSelector:@selector(notificationMore) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationMore{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"consultation" forKey:@"type"];
    [intent.args setValue:@"专家解疑" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnCleanOnTouch:(id)sender {
     [self performSelector:@selector(notificationCleanCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationCleanCar
{
    if([SHLocationManager.instance userlocation] && [SHLocationManager.instance userlocation].location){
        SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
        [intent.args setValue:@"洗车" forKey:@"title"];
        [intent.args setValue:@"clean" forKey:@"type"];
        
        [[UIApplication sharedApplication]open:intent];
    }else{
        if ([CLLocationManager locationServicesEnabled] &&
            [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ){
            [self showAlertDialog:@"系统仍在定位，请稍后再试.."];
        }
        else{
            [self showAlertDialog:@"亲爱的用户，我们需要您的位置信息搜索最近的商户，请您在\n[设置]->[隐私]->[定位服务]找到[养车宝宝]，并选择授权.感谢您的支持"];
        }
        
    }
}

- (IBAction)btnCheckOnTouch:(id)sender {
     [self performSelector:@selector(notificationCheck) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationCheck
{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"上门检测" forKey:@"title"];
    [intent.args setValue:@"check" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];

}

- (IBAction)btnCarManageOnTouch:(id)sender
{
    [self performSelector:@selector(notificationMyCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (IBAction)btnCLoseGuildOnTouch:(id)sender {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        viewguild.alpha = 0;
    } completion:^(BOOL finished) {
        [viewguild removeFromSuperview];
    }];
}

- (IBAction)btn3OnTouch:(id)sender {
    [self performSelector:@selector(notificationMore) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];

}

- (IBAction)btn2OnTouch:(id)sender {
    [self performSelector:@selector(notificationCheck) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];

}

- (IBAction)btn1OnTouch:(id)sender {
       [self performSelector:@selector(notificationHtml) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
  }

- (void)notificationHtml
{
    SHIntent * intent  = [[SHIntent alloc ]init:@"webview" delegate:nil containner:self.navigationController];
    NSString * url=  [NSString stringWithFormat:@"guaguale/index.jsp?mobile=%@",SHEntironment.instance.loginName];
    [intent.args setValue:URL_FOR(url) forKey:@"url"];
    [intent.args setValue:@"洗车卷抽奖" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];

}

- (void)notificationMyCar
{
    SHIntent * intent = [[SHIntent alloc]init:@"mycarlist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}
@end
