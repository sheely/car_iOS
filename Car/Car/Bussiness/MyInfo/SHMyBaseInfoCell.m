//
//  SHMyBaseInfoCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/26/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMyBaseInfoCell.h"

@implementation SHMyBaseInfoCell

- (void)loadSkin
{
    [super loadSkin];
    self.imgHead.layer.cornerRadius = 5;
    self.imgHead.layer.masksToBounds = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
