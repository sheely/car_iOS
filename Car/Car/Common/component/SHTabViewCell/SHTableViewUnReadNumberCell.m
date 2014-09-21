//
//  SHTableViewUnReadNumberCell.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-10-29.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewUnReadNumberCell.h"

@implementation SHTableViewUnReadNumberCell


- (void) setBadge:(int)badge
{
    if(badge > 0 ){
        self.imgBadge.hidden = NO;
        self.labBadge.hidden = NO;
        if(badge > 9){
            self.labBadge.text = @"N";
        }else{
            self.labBadge.text = [NSString stringWithFormat:@"%d",badge];
        }
    }else{
        self.imgBadge.hidden = YES;
        self.labBadge.hidden = YES;
    }
}

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

@end
