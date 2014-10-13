//
//  SHMainPageViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMainPageViewController.h"

@interface SHMainPageViewController ()

@end

@implementation SHMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车宝宝";
    scrollview.contentSize = CGSizeMake(self.view.frame.size.width * 3, scrollview.frame.size.height);
//    pagecontrol
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_car"];
    if(dic){
        labBrand.text = [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"carcategoryname"],[dic valueForKey:@"carseriesname"]];
        labCardNo.text =[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"provincename"],[dic valueForKey:@"carcardno"]];
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
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"保养" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnRepair:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"维修" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];

}

- (IBAction)btnInsuranceOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"保险" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];

}

- (IBAction)btnMoreOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"更多" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];

}

- (IBAction)btnCleanOnTouch:(id)sender {
     [self performSelector:@selector(notificationCleanCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
  }

- (void)notificationCleanCar
{
    if([SHLocationManager.instance userlocation]){
        SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
        [intent.args setValue:@"测试" forKey:@"title"];
        [intent.args setValue:@"clean" forKey:@"type"];
        
        [[UIApplication sharedApplication]open:intent];
    }else{
        [self showAlertDialog:@"仍在定位，请稍后再试"];
    }
}

- (IBAction)btnCheckOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"shoplist" delegate:self containner:self.navigationController];
    [intent.args setValue:@"测试" forKey:@"title"];
    [intent.args setValue:@"check" forKey:@"type"];
    [[UIApplication sharedApplication]open:intent];
}


- (IBAction)btnCarManageOnTouch:(id)sender
{
    [self performSelector:@selector(notificationMyCar) afterNotification:NOTIFICATION_LOGIN_SUCCESSFUL];
}

- (IBAction)btnTabOnTouch:(id)sender
{
    [self showAlertDialog:@""];
}

- (void)notificationMyCar
{
    SHIntent * intent = [[SHIntent alloc]init:@"mycarlist" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:intent];

}
@end
