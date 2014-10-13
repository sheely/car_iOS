//
//  SHSubCategaryViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHSubCategaryViewController.h"

@interface SHSubCategaryViewController ()

@end

@implementation SHSubCategaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车系选择";

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNext
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"carcategoryid"] forKey:@"carcategoryid"];
    post.URL = URL_FOR(@"carseriesidquery.action");
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"carseriesid"];
        mIsEnd = YES;
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
        [t.respinfo show];
        
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHTableViewGeneralCell * cell = [tableView dequeueReusableGeneralCell];
    cell.labTitle.text = [dic valueForKey:@"carseriesidname"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(subCategarySubmit:)]){
        [( id<SHSubCategaryViewControllerDeleate> ) self.delegate subCategarySubmit:[mList objectAtIndex:indexPath.row]];
        
    }
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
