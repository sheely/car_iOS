//
//  ntironment.h
//  Core
//
//  Created by sheely on 13-9-12.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHVersion.h"

@interface SHEntironment : NSObject
{
}
@property (nonatomic,copy) NSString* loginName;
@property (nonatomic,strong) NSString* password;
@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong,readonly) NSString* deviceid;
@property (nonatomic,strong) NSString* sessionid;
@property (nonatomic,readonly,strong) SHVersion * version;
@property (nonatomic,readonly,copy) NSString * deviceInfo;

+ (SHEntironment* )instance;
@end
