//
//  SHConfigManager.h
//  CoreTest
//
//  Created by sheely.paean.Nightshade on 10/7/13.
//  Copyright (c) 2013 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum  {
    SHConfigStatusSuccess,
    SHConfigStatusFaile
    }SHConfigStatus;

@interface SHConfigManager : NSObject <SHTaskDelegate,UIAlertViewDelegate>

@property (nonatomic,copy) NSString * URL;
@property (nonatomic,copy,readonly) NSString * updateDate;
//@property (nonatomic,strong) SHVersion * newVersion;
@property (nonatomic,strong,readonly) SHVersion * newversion;
@property (nonatomic,strong,readonly) SHVersion * minversion;
@property (nonatomic,copy,readonly)   NSString * content;
@property (nonatomic,strong,readonly) NSArray* listupdateurls;
@property (nonatomic,strong,readonly) NSDictionary * result;
@property (nonatomic,assign,readonly) BOOL hasPushNotice;
@property (nonatomic,assign,readonly) BOOL isMaintenanceMode;
@property (nonatomic,copy,readonly) NSString * pushNotice;
@property (nonatomic,assign,readonly) SHConfigStatus status;
//updateinfo
@property (nonatomic,assign,readonly) NSDictionary* updateInfo;
@property (nonatomic,assign,readonly) NSDictionary* configInfo;
- (void) refresh;

- (BOOL) show;

+ (SHConfigManager*)instance;

@end
