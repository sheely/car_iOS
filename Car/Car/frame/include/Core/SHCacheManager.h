//
//  SHCacheManager.h
//  Core
//
//  Created by sheely on 13-9-16.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCacheManager : NSObject

+ (SHCacheManager*)instance;

- (BOOL)push:(NSData *)data forKey:(NSString *)url;

- (void) clear;

- (NSData * )fetch:(NSString*)url;

- (NSArray * )fetchOdTime:(NSString*)url;
@end
