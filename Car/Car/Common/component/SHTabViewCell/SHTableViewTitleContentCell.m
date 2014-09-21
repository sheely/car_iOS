//
//  SHTableViewTitleContentCell.m
//  Zambon
//
//  Created by sheely on 13-9-8.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHTableViewTitleContentCell.h"

@implementation SHTableViewTitleContentCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)loadSkin
{
    [super loadSkin];
    self.labTitle.userstyle = @"labmiddark";
    self.labContent.userstyle = @"labminlight";
}

@end
