//
//  SHFuck.h
//  Core
//
//  Created by sheely on 13-10-15.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFuck : NSObject
+ (NSString*) stringForKey:(NSString *)key  result :(NSDictionary * )dic extra:(NSDictionary*) ext;
//+ (int)integerForKey:(NSString *)key : dic :(NSDictionary * )dic extra:(NSArray*) ext ;
@end
