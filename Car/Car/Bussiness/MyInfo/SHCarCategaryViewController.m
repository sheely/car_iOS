//
//  SHCarCategaryViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarCategaryViewController.h"
#import "SHCarCategaryCellInfoCell.h"

@interface SHCarCategaryViewController ()

@end

@implementation SHCarCategaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车型选择";
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
    post.URL = URL_FOR(@"carcategoryquery.action");
    [post start:^(SHTask *t) {
        mIsEnd = YES;
        mList = [t.result valueForKey:@"carcategorys"];
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];

    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHCarCategaryCellInfoCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCarCategaryCellInfoCell" owner:nil options:nil]objectAtIndex:0];
    cell.labTitle.text = [dic valueForKey:@"carcategoryname"];
    [cell.imgIcon setUrl:[dic valueForKey:@"carcategorylogo"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(categarySubmit:)]){
        [( id<SHCategaryViewControllerDeleate> ) self.delegate categarySubmit:[mList objectAtIndex:indexPath.row]];
        
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
