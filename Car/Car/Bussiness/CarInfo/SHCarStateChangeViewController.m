//
//  SHCarStateChangeViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 11/19/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarStateChangeViewController.h"
#import "SHRepairPortCell.h"

@interface SHCarStateChangeViewController ()

@end

@implementation SHCarStateChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车况变化报告";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"chekuangbianhuareport.action");
    if([self.intent.args valueForKey:@"reportid"]){
        [post.postArgs setValue:[self.intent.args valueForKey:@"reportid"]forKey:@"reportid"];
    }
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"kqbhentities"];
        mIsEnd = YES;
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        mIsEnd = YES;
        [t.respinfo show];
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHRepairPortCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHRepairPortCell" owner:nil options:nil] objectAtIndex:0];
    cell.labItem.text = [NSString stringWithFormat:@"项目:%@",[dic valueForKey:@"item"]];
    cell.labPrice.text =[NSString stringWithFormat:@"日期:%@",[dic valueForKey:@"date"]];
    cell.labCount.text = [NSString stringWithFormat:@"新状态:%@", [dic valueForKey:@"curstate"]];
    cell.labBrand.text = [NSString stringWithFormat:@"原状态:%@",[dic valueForKey:@"orstate"]];
    return cell;
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
