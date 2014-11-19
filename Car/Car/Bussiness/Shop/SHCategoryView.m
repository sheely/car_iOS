//
//  SHCategoryView.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/28/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCategoryView.h"

@implementation SHCategoryView

@synthesize selected = _selected;


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
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected_
{
    _selected = selected_;
    if(_selected){
        self.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorNavigation"].CGColor;
        [self.superview addSubview:self];
        self.imgSelected.hidden = NO;
        
    }else{
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.imgSelected.hidden = YES;

    }
}

@end
