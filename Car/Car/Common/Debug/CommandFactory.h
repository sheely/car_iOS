//
//  CommandFactory.h
//  Aroundme
//
//  Created by sheely.paean.Nightshade on 2/14/13.
//  Copyright (c) 2013 dianping.com. All rights reserved.
//
#import "Command.h"
#import <objc/runtime.h>

@interface CommandFactory : NSObject

/*
 构建命令
 */
+ (Command*) factoryByName:(NSString*)name;
@end
