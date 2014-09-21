//
//  SHTableViewTitleContentBottomCell.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-10-24.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewTitleContentBottomCell.h"

@implementation SHTableViewTitleContentBottomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)loadSkin
{
    [super loadSkin];
     self.labBottom.userstyle = @"labminlight";
}
@end
