//
//  SHShopPinAnnotationView.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/29/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopPinAnnotationView.h"

@implementation SHShopPinAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.imgView.layer.masksToBounds = YES;
}

@end
