//
//  SHFlowManager.h
//  Core
//
//  Created by sheely on 13-12-10.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SHFLOW_PUSH_UPDATE  @"shflow_push_update"

typedef enum
{
    SHWayDown,
    SHWayUp,
} SHWay;

@interface SHFlowManager : NSObject<SHTaskDelegate>
{
    long long mUp;
    long long mDown;
    //NSDate * mDate;
}

@property (nonatomic,assign,readonly) SHWay lastway;
@property (nonatomic,assign,readonly) long long  lastpackage;
@property (nonatomic,assign,readonly) long long  downFlow;
@property (nonatomic,assign,readonly) long long  upFlow;
@property (nonatomic,retain,readonly) NSDate* lastdate;
@property (nonatomic,copy) NSString * URL;
+ (SHFlowManager*)instance;

- (void)push:(long ) kb  way: (SHWay) way;

- (void)clear;

- (void)save;

- (void)reFresh;

@end
