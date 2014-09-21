//
//  LogCMD.m
//  Aroundme
//
//  Created by W Sheely on 13-3-6.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//

#import "LogCMD.h"

@implementation LogCMD
- (void)description{
    [NVDebugPanelController.instance addLog: @"打开crash日志"];
}
- (void)execute{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																		NSUserDomainMask, YES) objectAtIndex:0];
    NSString *crashFilePath = [documentsDirectory stringByAppendingPathComponent:@"crash.txt"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if([fileManager fileExistsAtPath:crashFilePath]) {
		//NSError *error = nil;
		// 读取文件内容
		NSString *crashContent = [NSString stringWithContentsOfFile:crashFilePath encoding:NSUTF8StringEncoding error:nil];
        [fileManager removeItemAtPath:crashFilePath error:nil];
        [NVDebugPanelController.instance addLog:  crashContent];
         
    }else{
         [NVDebugPanelController.instance addLog:  @"未发现日志或已上传"];
    }
}
@end

@implementation logger 



@end
