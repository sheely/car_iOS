//
//  SHOrderListViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/16/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHOrderListViewController.h"
#import "SHOrderHeaderView.h"
#import "SHOrderItemCell.h"

@interface SHOrderListViewController ()

@end

@implementation SHOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showWaitDialogForNetWork];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"ordersquery.action");
    [post.postArgs setValue:[NSNumber numberWithInt:99] forKey:@"ordertype"];
    [post.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"pageno"];
    [post.postArgs setValue:[NSNumber numberWithFloat:20] forKey:@"pagesize"];
    [post start:^(SHTask *t) {
        ;
        [self dismissWaitDialog];
    } taskWillTry:nil
  taskDidFailed:^(SHTask *t) {
      [self dismissWaitDialog];

  }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHOrderItemCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHOrderItemCell" owner:nil options:nil] objectAtIndex:0];
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SHOrderHeaderView * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHOrderHeaderView" owner:nil options:nil] objectAtIndex:0];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
