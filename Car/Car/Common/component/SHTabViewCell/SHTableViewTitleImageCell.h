//
//  SHTableViewTitleImageCell.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewCell.h"
#import "SHTableViewGeneralCell.h"

@interface SHTableViewTitleImageCell : SHTableViewGeneralCell
{

}
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@end
