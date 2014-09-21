//
//  SHTableViewSelectCell.m
//  offer_neptune
//
//  Created by yebaohua on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewSelectCell.h"

@implementation SHTableViewSelectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadSkin
{
    [super loadSkin];
    self.labTitle.userstyle = @"labmiddark";
    
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
