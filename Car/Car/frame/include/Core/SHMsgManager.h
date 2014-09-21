//
//  SHMessageManager.h
//  Core
//
//  Created by WSheely on 14-5-15.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHResMsgM.h"
#import "SHMsgM.h"

@interface SHMsgManager : NSObject<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * mSocket;
    NSMutableDictionary *mStorage;
    NSThread * mSenderThread;
    NSMutableArray *mSenderList;
    SHMsgM * msgHeart;
    int mHeartTime;//间隔时间
}
@property (assign,nonatomic) BOOL isWorking;

@property (copy,nonatomic) NSString* ipAddress;

@property (assign,nonatomic) int port;

- (void)connect : (NSString*) address port:(int) port;

+ (SHMsgManager*)instance;

- (void) addMsg : (SHMsg*) msg taskDidFinished :(void(^)(SHResMsgM *))taskfinished taskWillTry : (void(^)(SHResMsgM *))tasktry  taskDidFailed : (void(^)(SHResMsgM *))taskFailed;

@end
