//
//  SHTableViewEditGeneralCell.m
//  Zambon
//
//  Created by yebaohua on 13-12-7.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHTableViewEditGeneralCell.h"

@implementation SHTableViewEditGeneralCell

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
    mPlan.layer.cornerRadius = 4;
    mPlan.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorStyleLight"];
    self.txtTitle.layer.cornerRadius = 4;
    
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
