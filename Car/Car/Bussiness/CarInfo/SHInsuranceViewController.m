//
//  SHInsuranceViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/14/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHInsuranceViewController.h"

@interface SHInsuranceViewController ()

@end

@implementation SHInsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到期提醒";
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"insurancereportquery.action");
    [post.postArgs setValue:[NSNumber numberWithInt:2] forKey:@"reporttype"];
    if([self.intent.args valueForKey:@"reportid"]){
        [post.postArgs setValue:[self.intent.args valueForKey:@"reportid"] forKey:@"reportid"];
    }
    [post start:^(SHTask *t) {
        self.labMin.text = [NSString stringWithFormat:@"¥%d",[[t.result valueForKey:@"minprice"] intValue]];
        self.labMax.text = [NSString stringWithFormat:@"¥%d",[[t.result valueForKey:@"maxprice"] intValue]];
        self.labDes.text = [t.result valueForKey:@"itemdesc"];
        self.title = [t.result valueForKey:@"daoqiitem"];
        [self dismissWaitDialog];
        
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];

    }];

    // Do any additional setup after loading the view from its nib.
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnSubmit.layer.cornerRadius = 5;
    self.btnSubmit.layer.masksToBounds = 5;

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

@end
