//
//  SHMainPageViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMainPageViewController.h"
#import "SHChatListHelper.h"

@interface SHMainPageViewController ()
{
    NSTimer * timer;
    int index;
    int direct;
}
@end

@implementation SHMainPageViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestChatList) name:NOTIFICATION_UPDATE_REQUIRE object:nil];
    [self requestChatList];
//    pagecontrol
    // Do any additional setup after loading the view from its nib.
}
- (void)requestChatList
{
    //[self showWaitDialogForNetWork];
    if(SHEntironment.instance.loginName.length > 0){
        SHPostTaskM * task = [[SHPostTaskM alloc]init];
        task.URL= URL_FOR(@"acceptquestionlist.action");
        [task.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"pageno"];
        [task.postArgs setValue:[NSNumber numberWithInt:20] forKey:@"pagesize"];
        [task start:^(SHTask *t) {
            NSArray * mList = [t.result valueForKey:@"questions"];
            for (NSDictionary * dic  in mList) {
                SHChatItem * item = [[SHChatItem alloc]init];
                item.problemdesc = [dic valueForKey:@"problemdesc"];
                item.asktime = [dic valueForKey:@"asktime"];
                item.uploadpicture = [dic valueForKey:@"uploadpicture"];
                item.latestmessage = [dic valueForKey:@"latestmessage"];
                item.problemdesc = [dic valueForKey:@"problemdesc"];
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
    }
   
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
    [intent.args setValue:@"保险" forKey:@"title"];
    [intent.args setValue:@"insurance" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnMoreOnTouch:(id)sender {
    [self performSelector:@selector(notificationMore) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (void)notificationMore{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"consultation" forKey:@"type"];
    [intent.args setValue:@"咨询" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnCleanOnTouch:(id)sender {
     [self performSelector:@selector(notificationCleanCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
  }

- (void)notificationCleanCar
{
    if([SHLocationManager.instance userlocation]){
        SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
        [intent.args setValue:@"洗车" forKey:@"title"];
        [intent.args setValue:@"clean" forKey:@"type"];
        
        [[UIApplication sharedApplication]open:intent];
    }else{
        [self showAlertDialog:@"仍在定位，请稍后再试"];
    }
}

- (IBAction)btnCheckOnTouch:(id)sender {
     [self performSelector:@selector(notificationCheck) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
   }
- (void)notificationCheck
{
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"一键检测" forKey:@"title"];
    [intent.args setValue:@"check" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];

}


- (IBAction)btnCarManageOnTouch:(id)sender
{
    [self performSelector:@selector(notificationMyCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (IBAction)btnTabOnTouch:(id)sender
{
 //   [self showAlertDialog:@""];
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
    [intent.args setValue:URL_FOR(@"guaguale/index.html") forKey:@"url"];
    [intent.args setValue:@"洗车卷抽奖" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];

}
- (void)notificationMyCar
{
    SHIntent * intent = [[SHIntent alloc]init:@"mycarlist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}
@end
