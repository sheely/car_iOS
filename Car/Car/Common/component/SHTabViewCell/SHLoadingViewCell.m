//
//  SHLoadingViewCell.m
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHLoadingViewCell.h"

@implementation SHLoadingViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.chrysanthemum startAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
