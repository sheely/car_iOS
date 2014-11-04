//
//  SHChatListHelper.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHChatItem.h"

@interface SHChatListHelper : NSObject
{
    NSMutableArray * mList;
}

- (NSArray*) list;
+ (SHChatListHelper*) instance;

- (void) addItem:(SHChatItem*)item;

- (void) notice;

- (void) cleanNewFlag:(NSString*)name;

- (void) removeAll;

@end
