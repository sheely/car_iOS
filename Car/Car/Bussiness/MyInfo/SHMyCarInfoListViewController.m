//
//  SHMyCarInfoListViewController.m
//  Car
//
//  Created by WSheely on 14-10-7.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHMyCarInfoListViewController.h"
#import "SHCarInfoListCell.h"
@interface SHMyCarInfoListViewController ()

@end

@implementation SHMyCarInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的车辆";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil title:@"添加" target:self action:@selector(btnAdd:)];
    // Do any additional setup after loading the view from its nib.
}



- (void)btnAdd:(NSObject*)b
{
    SHIntent* i = [[SHIntent alloc]init:@"editcarinfo"delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];
}

- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"mycarquery.action");
    [post start:^(SHTask *t) {
        //
        mList = [t.result valueForKey:@"mycars"];
        mIsEnd = YES;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)editcarinfosubmit:(NSObject*)c
{
    [self loadNext];
}
- (float)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHCarInfoListCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCarInfoListCell" owner:nil options:nil] objectAtIndex:0];
    cell.labTitle.text = [dic valueForKey:@"carcategoryname"];
    cell.labContent.text = [dic valueForKey:@"carseriesname"];
    [cell.imgView setUrl:[dic valueForKey:@"carlogo"]];
    if([[dic valueForKey:@"isactivited"] intValue]){
        cell.imgState.hidden = NO;
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"user_car"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        cell.imgState.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHPostTaskM * p = [[SHPostTaskM alloc]init];
    [self showWaitDialogForNetWork];
    p.URL = URL_FOR(@"mycarmaintanance.action");
    [p.postArgs setValue:[dic valueForKey:@"carid"] forKey:@"carid"];
    [p.postArgs setValue:[NSNumber numberWithInt:3] forKey:@"optype"];
    [p start:^(SHTask *t) {
        [self dismissWaitDialog];

        [self loadNext];
        
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

@end
