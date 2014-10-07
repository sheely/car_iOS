//
//  SHCarInfoListCell.m
//  Car
//
//  Created by WSheely on 14-10-7.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCarInfoListCell.h"

@implementation SHCarInfoListCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)loadSkin
{
    [super loadSkin];
    self.labContent.userstyle = @"labmiddark";
}
@end
