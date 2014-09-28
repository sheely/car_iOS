//
//  SHShopInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/25/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopInfoViewController.h"

@interface SHShopInfoViewController ()

@end

@implementation SHShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户详情";
    // Do any additional setup after loading the view from its nib.
}

- (void)loadSkin
{
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

- (IBAction)btnContact:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18616378436"]];

}
@end
