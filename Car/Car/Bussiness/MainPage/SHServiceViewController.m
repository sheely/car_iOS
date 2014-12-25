//
//  SHServiceViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 12/11/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHServiceViewController.h"

@interface SHServiceViewController ()

@end

@implementation SHServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showWaitDialogForNetWork];
    self.title = @"用户使用协议";
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL= URL_FOR(@"loginprivacy.action");
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
        self.txtField.text = [t.result valueForKey:@"detailcontent"];
        self.txtField.font = [UIFont systemFontOfSize:16];
        self.title = [t.result valueForKey:@"sumamry" ];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];
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

@end
