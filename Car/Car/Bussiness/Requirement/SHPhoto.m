//
//  SHPhoto.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/13/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHPhoto.h"

@implementation SHPhoto

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadSkin
{
    self.imgView.layer.cornerRadius = 5;
    self.imgView.layer.masksToBounds = YES;
}
@end
