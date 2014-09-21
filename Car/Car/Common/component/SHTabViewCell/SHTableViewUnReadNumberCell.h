//
//  SHTableViewUnReadNumberCell.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-10-29.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewTitleImageCell.h"

@interface SHTableViewUnReadNumberCell : SHTableViewTitleImageCell


@property (weak, nonatomic) IBOutlet UIImageView *imgBadge;
@property (weak, nonatomic) IBOutlet UILabel *labBadge;
@property (nonatomic,assign) int badge;



@end
