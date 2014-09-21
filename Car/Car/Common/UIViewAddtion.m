//
//  UIButtonAddtion.m
//  Core
//
//  Created by sheely on 13-9-4.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "UIViewAddtion.h"
@implementation UIView(style)

- (void)setUserstyle:(NSString *)userstyle
{
    //[NVSkin.instance accommodate:self key:(NSString*) style];
    [SHSkin.instance accommodate:self :userstyle];
}

-(NSString *)userstyle
{
       return nil;
}

@end
