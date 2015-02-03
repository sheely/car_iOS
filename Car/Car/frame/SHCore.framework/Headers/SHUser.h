//
//  User.h
//  Core
//
//  Created by sheely on 13-10-29.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHUser : NSObject

+ (SHUser*) instance;

@property (nonatomic,strong) NSString* userId;

@end
