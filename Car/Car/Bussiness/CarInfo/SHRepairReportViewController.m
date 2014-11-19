//
//  SHRepairReportViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 11/18/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHRepairReportViewController.h"
#import "SHRepairPortCell.h"

@interface SHRepairReportViewController ()

@end

@implementation SHRepairReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆维修报告";
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"repairreportquery.action");
    [post.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"reporttype"];
    if([self.intent.args valueForKey:@"reportid"]){
        [post.postArgs setValue:[self.intent.args valueForKey:@"reportid"] forKey:@"reportid"];
    }
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"repairentities"];
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
    cell.labItem.text = [NSString stringWithFormat:@"维护项目:%@",[dic valueForKey:@"repairitem"]];
    cell.labPrice.text = [NSString stringWithFormat:@"总价:%d(元)",[[dic valueForKey:@"summaryprice"] intValue]];
    cell.labCount.text = [NSString stringWithFormat:@"数量:%d(%@)", [[dic valueForKey:@"repaircount"] intValue],[(NSString*)[dic valueForKey:@"repairunit"] length]  > 0 ? [dic valueForKey:@"repairunit"]:@"个"];
    cell.labBrand.text = [NSString stringWithFormat:@"替换品牌:%@",[dic valueForKey:@"repairbrand"]];
    return cell;
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
