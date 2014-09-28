//
//  SHCarInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarInfoViewController.h"
#import "SHCarItemCollectionViewCell.h"
#import "SHCarInfoReportCell.h"

@interface SHCarInfoViewController ()

@end

@implementation SHCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车况档案";
    [self.collectView registerNib: [UINib nibWithNibName:@"SHCarItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"car_item_collect"];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    mIsEnd = YES;
    mList = @[@"",@"",@"",@""];
    [self.tableView reloadData];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 14;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHCarItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"car_item_collect" forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.labTitle.text = @"刹车片";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_breaking"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_warning"];
    }else if (indexPath.row == 1){
        cell.labTitle.text = @"机油";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_gas"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_fault"];
    }else{
        cell.labTitle.text = @"变速箱";
        cell.imgView.image = [UIImage imageNamed:@"set_icon_set"];
        cell.imgState.image =  [UIImage imageNamed:@"set_status_normal"];
    }
        
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)loadSkin
{
    [super loadSkin];
  
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCarInfoReportCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCarInfoReportCell" owner:nil options:nil]objectAtIndex:0];
    if(indexPath.row == 0){
        cell.imgState.hidden = NO;
        cell.imgIcon.image = [UIImage imageNamed:@"lis_icon_report"];
        cell.labTitle.text = @"车辆检测报告";
        cell.labContent.text = @"2015-04-04";
    }else if (indexPath.row == 1){
        cell.imgIcon.image = [UIImage imageNamed:@"lis_icon_insurance"];
        cell.labTitle.text = @"保险即将到期";
        cell.labContent.text = @"2015-04-04";
    }else if (indexPath.row == 2){
        cell.imgIcon.image = [UIImage imageNamed:@"lis_icon_repair"];
        cell.labTitle.text = @"车辆维修报告";
        cell.labContent.text = @"2015-04-04";
    }else if (indexPath.row == 3){
        cell.imgIcon.image = [UIImage imageNamed:@"lis_icon_status"];
        cell.labTitle.text = @"车况变化报告";
        cell.labContent.text = @"2015-04-04";
    }
    
    
    return cell;
}

@end
