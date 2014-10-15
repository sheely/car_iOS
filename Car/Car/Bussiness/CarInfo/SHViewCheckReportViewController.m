//
//  SHViewCheckReportViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/14/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewCheckReportViewController.h"
#import "SHCheckItemView.h"

@interface SHViewCheckReportViewController ()

@end

@implementation SHViewCheckReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆检测报告";
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    mIsEnd = YES;
    mList = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    [self.tableView reloadData];
}

- (float)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCheckItemView * view = [[[NSBundle mainBundle]loadNibNamed:@"SHCheckItemView" owner:nil options:nil] objectAtIndex:0];
    return view;
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
