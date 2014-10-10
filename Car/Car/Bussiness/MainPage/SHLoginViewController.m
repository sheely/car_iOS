//
//  SHLoginViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/6/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHLoginViewController.h"

@interface SHLoginViewController ()

@end

@implementation SHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
#ifdef DEBUG
    self.txtLoginName.text = @"18912091298";
    self.txtPassword.text = @"2323";

#else
    
#endif
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
    [p.postArgs setValue:@"x" forKey:@"appuuid"];
    [p start:^(SHTask *t) {
        [self dismissWaitDialog];
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
    if(SHEntironment.instance.loginName.length >0 ){
        return YES;
    }
    return NO;
}
@end
