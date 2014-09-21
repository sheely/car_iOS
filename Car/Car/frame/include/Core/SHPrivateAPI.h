//
//  PrivateAPI.h
//  Core
//
//  Created by sheely on 13-12-9.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
struct CTResult

{
    int flag;
    int a;
};
@interface SHPrivateAPI : NSObject
//imei


+ (NSString *) getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

+ (BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *) serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;
+ (BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

+ (NSString*) guid;

+ (void) clearguid;

+ (void) debugguid;

+ (NSString*) reguid;
@end
