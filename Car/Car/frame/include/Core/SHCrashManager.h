//
//  SHCrashManager.h
//  Core
//
//  Created by sheely on 13-9-25.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHTask.h"

@interface SHCrashManager : NSObject <SHTaskDelegate>

@property (nonatomic,copy) NSString* URL;

+ (SHCrashManager*)instance;

+(void)writeFile:(NSString *)file;

@end
