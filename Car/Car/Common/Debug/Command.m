//
//  Command.m
//  Aroundme
//
//  Created by W Sheely on 13-2-6.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//

#import "Command.h"

@interface Command ()

@end

@implementation Command
@synthesize name;
@synthesize args;
- (void)description{
     [NVDebugPanelController.instance addLog:  @"命名"];
//    [NSString stringWithFormat:@"%@/%@",URL_HEADER,@"s"];
//    CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
}

- (void)execute{
    [NVDebugPanelController.instance addLog:  @"命令执行完成"];
}
- (void)dealloc{
   name = nil;
    self.args = nil;
}
@end
