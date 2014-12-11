//
//  SHLoginViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/6/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHLoginViewController.h"
#import "AppDelegate.h"

@interface SHLoginViewController ()
{
    NSTimer * timer;
    int  count ;
}
@end

@implementation SHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
    self.txtLoginName.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"STORE_USER_INFO"] valueForKey:@"username"];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnCode.layer.cornerRadius = 5;
    self.btnSubmit.layer.cornerRadius= 5;
    self.btnCode.layer.masksToBounds = YES;
    self.btnSubmit.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSubmitOnTouch:(id)sender
{
    SHEntironment.instance.loginName = self.txtLoginName.text;
    SHEntironment.instance.password = self.txtPassword.text;
    [self showWaitDialogForNetWork];
    SHPostTaskM * p = [[SHPostTaskM alloc]init];
    p.URL = URL_FOR(@"login.action");
    [p.postArgs setValue:[AppDelegate token ] forKey:@"appuuid"];
    [p start:^(SHTask *t) {
        [self dismissWaitDialog];
      
        //user_car
        [[NSUserDefaults standardUserDefaults] setValue:[t.result valueForKey:@"activitedcar"] forKey:@"user_car"];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init ];
        [dic setValue:self.txtLoginName.text forKey:@"username"];
        [dic setValue:self.txtPassword.text forKey:@"password"];
        [dic setValue:[t.result valueForKey:@"myheadicon"] forKey:@"myheadicon"];
        
        [[NSUserDefaults standardUserDefaults] setObject:dic  forKey:STORE_USER_INFO];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];

        [t.respinfo show];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+(BOOL)__GET_PRE_ACTION_STATE:(NSError*)e
{
    if(SHEntironment.instance.loginName.length >0 && SHEntironment.instance.password.length > 0 ){
        return YES;
    }
    return NO;
}


- (void) timerUp:(NSTimer*)t
{
    if(count == 0){
        count = 60;
        self.btnCode.enabled = NO;
    }
    [self.btnCode setTitle:[NSString stringWithFormat:@"[%d]秒后可以重试",count] forState:UIControlStateNormal];
    count --;
    if(count == 0){
        self.btnCode.enabled = YES;
        [timer invalidate];
        [self.btnCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnCodeOnTouch:(id)sender {
    if(self.txtLoginName.text.length == 0){
        [self showAlertDialog:@"手机号码不可为空"];
    }else{
        SHEntironment.instance.loginName = self.txtLoginName.text;
        SHEntironment.instance.password = @"";
        SHPostTaskM * p = [[SHPostTaskM alloc]init];
        p.URL = URL_FOR(@"smssend.action");
        [p start:^(SHTask *t) {
            [self showAlertDialog:@"验证码已发送"];
            [timer invalidate];
            timer = [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(timerUp:) userInfo:nil repeats:YES];
        } taskWillTry:^(SHTask *t) {
            ;
        } taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
        }];
        
    }
}
@end
