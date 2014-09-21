//
//  UITableViewAddtion.h
//  Zambon
//
//  Created by sheely on 13-11-20.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHLoadingViewCell.h"
@interface UITableView(Addition)

- (SHTableViewGeneralCell *)dequeueReusableGeneralCell;

- (SHTableViewTitleContentCell*)dequeueReusableTitleContentCell;

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell;

- (SHTableViewTitleImageCell*)dequeueReusableTitleImageCell2;

- (SHTableViewGeneralCell*)dequeueReusableTitleCustomCell:(NSString*)nibName identifier:(NSString*)identifier;

- (SHTableViewTitleContentBottomCell*)dequeueReusableTitleContentBottomCell;

- (SHTableViewUnReadNumberCell*) dequeueReusableunReadNumberCell;

- (SHNoneViewCell*)dequeueReusableNoneViewCell;

- (SHLoadingViewCell*)dequeueReusableLoadingCell;
@end
