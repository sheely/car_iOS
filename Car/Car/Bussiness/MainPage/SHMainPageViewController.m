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
    self.title = @"养车宝";
    // Do any additional setup after loading the view from its nib.
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
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"测试" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];
}

- (IBAction)btnCheckOnTouch:(id)sender {
    SHIntent * intent = [[SHIntent alloc]init:@"request" delegate:self containner:self.navigationController];
    [intent.args setValue:@"测试" forKey:@"title"];
    [[UIApplication sharedApplication]open:intent];
}
@end
