//
//  SHTableViewController.m
//  Core
//
//  Created by zywang on 13-9-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHTableViewController.h"
#import "SHTableViewGeneralCell.h"
#import "SHTableViewTitleImageCell.h"

@interface SHTableViewController ()

@end

@implementation SHTableViewController

@synthesize showTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mIsEnd) {
        if(mList.count == 0){
            return 1;
        }else{
            return mList.count;
        }
    }else{
        return mList.count + 1;
    }
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 44)];
    label.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    label.userstyle = @"labmidmilk";
    label.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundCell"];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)loadSkin
{
    [super loadSkin];
    if(self.showTitle){
        UIImage * img = [SHSkin.instance image:@"icon-top.png"];
        UIImageView * imgView =[[UIImageView alloc]initWithImage: img];
        imgView.frame = CGRectMake(self.tableView.frame.size.width/2 - img.size.width/2, -img.size.height - 10, img.size.width, img.size.height);
        [self.tableView addSubview:imgView];
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)loadNext
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (SHTableViewGeneralCell*)dequeueReusableGeneralCell
{
    
    return [self.tableView dequeueReusableGeneralCell];
}

- (SHTableViewTitleContentCell*)dequeueReusableTitleContentCell
{
    
    return [self.tableView dequeueReusableTitleContentCell];
}

- (SHTableViewGeneralCell*)dequeueReusableTitleCustomCell:(NSString*)nibName identifier:(NSString*)identifier
{
    
    return [self.tableView dequeueReusableTitleCustomCell:(NSString*)nibName identifier:(NSString*)identifier];
}

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell
{
    
    return [self.tableView dequeueReusableTitleImageCell];
}

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell2
{
    
    return [self.tableView dequeueReusableTitleImageCell2];
}

- (SHTableViewTitleContentBottomCell*)dequeueReusableTitleContentBottomCell
{
    
    return [self.tableView dequeueReusableTitleContentBottomCell];
}

- (SHTableViewUnReadNumberCell*)dequeueReusableunReadNumberCell
{
    
    return [self.tableView dequeueReusableunReadNumberCell];
}

- (SHNoneViewCell*)dequeueReusableNoneViewCell
{
    
    return [self.tableView dequeueReusableNoneViewCell];
}

- (SHLoadingViewCell*)dequeueReusableLoadingCell
{
    
    return [self.tableView dequeueReusableLoadingCell];
}

-(UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= mList.count || mList.count == 0 ){
        return 44;
    }else{
        return [self tableView:self.tableView heightForGeneralRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= mList.count || mList.count == 0 ){
        SHNoneViewCell * cell;
        if(mIsEnd){
            cell = [self dequeueReusableNoneViewCell];
            cell.labContent.text = @"暂无相关讯息...";
        }else{
            cell = [self dequeueReusableLoadingCell];
            [self loadNext];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        return [self tableView:tableView dequeueReusableStandardCellForRowAtIndexPath:indexPath];
    }
    return nil;
}



@end
