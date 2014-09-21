//
//  Task.h
//  Core
//
//  Created by zywang on 13-8-17.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHObject.h"
#import "Respinfo.h"

typedef enum 
{
    CacheTypeNone,
    CacheTypeKey,
    CacheTypeTimes//时间缓存
    
}CacheType;

@class SHTask;

@protocol SHTaskDelegate <NSObject>

@required
//必须
- (void)taskDidFinished:(SHTask*) task;
//可选
@optional
- (void)taskDidFailed:(SHTask*) task;
- (void)taskWillTry:(SHTask*) task;

@end

@interface SHTask : NSObject
{
    @protected
    NSString * _realURL;
    Respinfo * _respinfo;
    BOOL _isworking;
    void(^ __taskdidfinished)(SHTask *);
    void(^ __taskdidtaskFailed)(SHTask *);
}

@property (nonatomic,assign,readonly) BOOL isworking;
@property (nonatomic,strong,readonly) Respinfo * respinfo;
@property (nonatomic,strong,readonly) NSObject* result;
@property (nonatomic,weak) id<SHTaskDelegate>delegate;
@property (nonatomic,strong) NSString* URL;
@property (nonatomic,assign) CacheType cachetype;
@property (nonatomic,assign) BOOL  isCache;
@property (nonatomic,strong,readonly) NSDictionary* extra;
@property (nonatomic,assign) int tag;

- (void)start;

- (void)start:(void(^)(SHTask *))taskfinished taskWillTry : (void(^)(SHTask *))tasktry  taskDidFailed : (void(^)(SHTask *))taskFailed;

- (void)cancel;

+ (void)pull:(NSString*)url newUrl:(NSString*)newurl;
@end
