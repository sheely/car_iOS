//
//  GuidClear.m
//  Zambon
//
//  Created by sheely on 13-12-14.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "GuidClear.h"

@implementation GuidClear
- (void)description{
    [NVDebugPanelController.instance addLog: @"无参数:显示当前guid,\n参数位1,调整为debug模式下的guid,\n参数为2,重置一个guid并输出。"];
}
- (void)execute{

    if(self.args.count == 0){
      
        SHLog(@"guid:%@",[SHPrivateAPI guid]);
        
    }
    else if(self.args.count == 1){
        int type = ((NSString*)[self.args objectAtIndex:0]).integerValue;
        if(type == 1){
            [SHPrivateAPI debugguid];
        }else if (type == 2){
            SHLog(@"guid:%@",[SHPrivateAPI reguid]);
        }
    }
}

@end

@implementation gc

@end
