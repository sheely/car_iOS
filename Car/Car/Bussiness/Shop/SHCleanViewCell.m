//
//  SHCleanViewCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCleanViewCell.h"

@implementation SHCleanViewCell
@synthesize  dicInfo = _dicInfo;
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
    self.btnSubmit.layer.cornerRadius = 5;
    self.btnSubmit.layer.masksToBounds  =YES;
}
- (void)setDicInfo:(NSDictionary *)dicInfo_
{
    _dicInfo = dicInfo_;
}
@end
