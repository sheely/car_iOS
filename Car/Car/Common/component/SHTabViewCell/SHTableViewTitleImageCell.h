//
//  SHTableViewTitleImageCell.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewCell.h"
#import "SHTableViewGeneralCell.h"
#import "SHImageView.h"

@interface SHTableViewTitleImageCell : SHTableViewGeneralCell
{

}
@property (weak, nonatomic) IBOutlet SHImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@end
