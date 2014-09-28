//
//  SHQuitCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/26/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHQuitCell.h"

@implementation SHQuitCell

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
    self.btnQuit.layer.masksToBounds = YES;
    self.btnQuit.layer.cornerRadius = 5;
}

@end
