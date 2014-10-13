//
//  SHMyInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/26/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMyInfoViewController.h"
#import "SHQuitCell.h"

@interface SHMyInfoViewController ()

@end

@implementation SHMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (int )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(float) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 ||( indexPath.section == 2 && indexPath.row == 4)) {
        return 80;
    }
    return 44;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 2;
        
    }else if (section == 2){
        return 5;
    }
    return 0;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        UITableViewCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMyBaseInfoCell" owner:nil options:nil]objectAtIndex:0];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
           SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"我的车辆";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else {
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"我的优惠卷";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }
    }
    else if (indexPath.section == 2){
        if(indexPath.row == 0){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"五星好评";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 1){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"检查更新";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 2){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"关于我们";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 3){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.backgroundColor = [UIColor whiteColor];
            cell.labTitle.text = @"拨打客服电话";
            return cell;
        }else if (indexPath.row == 4){
            SHQuitCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHQuitCell" owner:nil options:nil]objectAtIndex:0];
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            SHIntent * intent = [[SHIntent alloc]init:@"mycarlist" delegate:self containner:self.navigationController];
            [[UIApplication sharedApplication]open:intent];

        }
    }else if (indexPath.section == 2){
        if(indexPath.row == 2){
            SHIntent * intent = [[SHIntent alloc]init:@"aboutus" delegate:self containner:self.navigationController];
            [[UIApplication sharedApplication]open:intent];
        }else if(indexPath.row == 3){
            NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",@"18616378436"];
            NSURL *url = [[NSURL alloc] initWithString:telUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
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
