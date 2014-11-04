//
//  SHServiceCenterViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/1/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHServiceCenterViewController.h"

@interface SHServiceCenterViewController ()
{
    SHOrderListViewController * morderlistviewcontroller;
    SHChatListViewController * mrequestlistviewcontroller;
}
@end

@implementation SHServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"受理中心";
    self.navigationItem.titleView = self.viewTitle;
    [self.viewTitle addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    mrequestlistviewcontroller = [[SHChatListViewController alloc]init];
    mrequestlistviewcontroller.view.frame = self.view.bounds;
    [self.view addSubview:mrequestlistviewcontroller.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)segmentedControlValueChanged:(UISegmentedControl*)controller
{
    if(controller.selectedSegmentIndex == 0){
         [self.view addSubview:mrequestlistviewcontroller.view];
    }else{
        if(morderlistviewcontroller == nil){
            morderlistviewcontroller = [[SHOrderListViewController alloc]init];
        }
         [self.view addSubview:morderlistviewcontroller.view];
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

@end
