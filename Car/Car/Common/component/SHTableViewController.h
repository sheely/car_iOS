//
//  SHTableViewController.h
//  Core
//
//  Created by zywang on 13-9-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHViewController.h"
#import "SHTableViewTitleContentBottomCell.h"
#import "SHTableViewTitleImageCell.h"
#import "SHTableViewTitleContentBottomCell.h"
#import "SHTableViewGeneralCell.h"
#import "SHTableViewUnReadNumberCell.h"
#import "SHNoneViewCell.h"

@interface SHTableViewController : SHViewController<UITableViewDelegate,UITableViewDataSource>
{
     NSMutableArray * mList;
    BOOL  mIsEnd;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL showTitle;

- (void)loadNext;

- (SHTableViewGeneralCell *)dequeueReusableGeneralCell;

- (SHTableViewTitleContentCell*)dequeueReusableTitleContentCell;

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell;

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell2;

- (SHTableViewGeneralCell*)dequeueReusableTitleCustomCell:(NSString*)nibName identifier:(NSString*)identifier;

- (SHTableViewTitleContentBottomCell*)dequeueReusableTitleContentBottomCell;

- (SHTableViewUnReadNumberCell*) dequeueReusableunReadNumberCell;

- (SHNoneViewCell*)dequeueReusableNoneViewCell;

- (UITableViewCell*) tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath;

@end

