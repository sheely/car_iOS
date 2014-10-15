//
//  SHCheckItemView.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/14/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCheckItemView.h"

@implementation SHCheckItemView

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
    self.imgPhoto.layer.masksToBounds = YES;
    self.imgPhoto.layer.cornerRadius = 5;
}

@end
