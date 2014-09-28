//
//  SHShopListCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/24/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopListCell.h"

@implementation SHShopListCell
-(void)loadSkin
{
    [super loadSkin];
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 5;
    self.labNewPrice.textColor = [UIColor orangeColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
