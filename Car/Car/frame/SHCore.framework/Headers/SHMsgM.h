//
//  SHMsgM.h
//  Core
//
//  Created by WSheely on 14-5-15.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMsgM : SHMsg
{
}

@property (strong,nonatomic) NSString * target;

@property (strong,nonatomic) NSMutableDictionary* args;

- (void)start:(void(^)(SHResMsgM *))taskfinished taskWillTry : (void(^)(SHResMsgM *))tasktry  taskDidFailed : (void(^)(SHResMsgM *))taskDidFailed;

@end
