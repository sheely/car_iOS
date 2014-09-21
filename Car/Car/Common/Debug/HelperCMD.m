//
//  HelperCMD.m
//  Aroundme
//
//  Created by W Sheely on 13-2-20.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//

#import "HelperCMD.h"

@implementation HelperCMD
- (void)execute{
    NSMutableString * cmd = [NSMutableString stringWithFormat:@"%@", @"command list \n"];
    [cmd appendFormat:@"help: 帮助\n"];
    [cmd appendFormat:@"cls : 清空屏幕\n"];
    [cmd appendFormat:@"ip\\ipconfig: 设置host地址\n"];
    [cmd appendFormat:@"ipconfig: 设置host地址\n"];
    [cmd appendFormat:@"logger : 读取log\n"];
    [cmd appendFormat:@"LogCMD: 读取log\n"];
    [cmd appendFormat:@"GuidClear: 无参数(显示当前guid),参数1(debug下的guid)参数2重置guid\n"];
    [cmd appendFormat:@"gc: 同GuidClear\n"];
    [NVDebugPanelController.instance addLog:cmd];
}
@end

@implementation help


@end