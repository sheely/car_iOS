//
//  SHPrivinceViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHProvinceViewController.h"

@interface SHProvinceViewController ()

@end

@implementation SHProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省份";
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
    post.URL = URL_FOR(@"provicequery.action");
    [post start:^(SHTask *t) {
        mIsEnd = YES;
        mList = [t.result valueForKey:@"provinces"];
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
    cell.labTitle.text = [NSString stringWithFormat:@"%@(%@)",[dic valueForKey:@"provincename"],[dic valueForKey:@"provincefullname"]];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(provinceSubmit:)]){
        [( id<SHProvinceViewControllerDelegate> ) self.delegate provinceSubmit:[mList objectAtIndex:indexPath.row]];
        
    }
}

@end
