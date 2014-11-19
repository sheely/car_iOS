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
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"checkreportquery.action");
    [post.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"reporttype"];
    if([self.intent.args valueForKey:@"reportid"]){
        [post.postArgs setValue:[self.intent.args valueForKey:@"reportid"] forKey:@"reportid"];
    }else{
        [post.postArgs setValue:@"dsfsdfsdsfd" forKey:@"reportid"];
    }
    [post.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"reporttype"];
    [post start:^(SHTask *t) {
        mIsEnd = YES;
        mList = [t.result valueForKey:@"deviceentities"];
        self.labSummer.text = [t.result valueForKey:@"summaryinformation"];
        [self dismissWaitDialog];
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        mIsEnd = YES;
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];
}

- (float)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHCheckItemView * view = [[[NSBundle mainBundle]loadNibNamed:@"SHCheckItemView" owner:nil options:nil] objectAtIndex:0];
    view.labTitle.text = [dic valueForKey:@"devicename"];
    view.labContent.text = [dic valueForKey:@"expertanswer"];
    if([[dic valueForKey:@"uploadpicture"] length]>0){
        [view.imgPhoto setUrl:[dic valueForKey:@"uploadpicture"]];
    }
    if([[dic valueForKey:@"devicestatus"] intValue ] == 0){
        view.imgState.image = [SHSkin.instance image:@"set_status_normal.png"];
    }else if([[dic valueForKey:@"devicestatus"] intValue] == 1){
        view.imgState.image = [SHSkin.instance image:@"set_status_fault.png"];
    }else {
        view.imgState.image = [SHSkin.instance image:@"set_status_warning.png"];
    }
    [view.imgIcon setUrl:[dic valueForKey:@"deviceslogo"]];
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
