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
#import "SHNetReel.h"


@interface SHMsgManager : NSObject<GCDAsyncSocketDelegate,SHNetReelDelegate>
{
    NSMutableDictionary *mStorage;
    NSThread * mSenderThread;
    NSMutableArray *mSenderList;
    SHMsgM * msgHeart;
    int mHeartTime;//间隔时间
    SHNetReel * _reel;
}

@property (nonatomic,strong) SHNetReel * reel;
+ (SHMsgManager*)instance;

- (void) addMsg : (SHMsg*) msg taskDidFinished :(void(^)(SHResMsgM *))taskfinished taskWillTry : (void(^)(SHResMsgM *))tasktry  taskDidFailed : (void(^)(SHResMsgM *))taskFailed;

@end
