//
//  SHOrderItemCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/19/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHOrderItemCell.h"

@implementation SHOrderItemCell

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
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.masksToBounds = YES;
}

@end
