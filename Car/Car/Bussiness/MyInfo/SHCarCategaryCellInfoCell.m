//
//  SHCarCategaryCellInfoCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarCategaryCellInfoCell.h"

@implementation SHCarCategaryCellInfoCell

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
    self.imgIcon.layer.masksToBounds = YES;
    self.imgIcon.layer.cornerRadius = 5;
}

@end
