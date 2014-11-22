//
//  SHChatListHelper.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatListHelper.h"
#import "SHChatItem.h"

@implementation SHChatListHelper
static SHChatListHelper * _instance;
- (id) init
{
    if(self = [super init]){
//        NSData * data = [[NSUserDefaults standardUserDefaults] valueForKey:@"SHChatListHelper"];
//        mList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if(mList == nil){
            mList = [[NSMutableArray alloc]init];
        }
    }
    return self;
}

- (NSArray*)list
{
    return mList;
}

+ (SHChatListHelper*)instance
{
    if(_instance == nil){
        _instance = [[SHChatListHelper alloc]init];
     
    }
    return _instance;
}

- (void)cleanNewFlag:(NSString*)name
{
    for (SHChatItem * item2 in mList) {
        if([item2.questionid isEqualToString:name]){
            item2.isNew = NO;
            break;
        }
    }
    [self notice];
}
- (void) notice
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CHATITEMLIST_CHANGED object:mList];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)  removeAll
{
    @synchronized(mList){
        [mList removeAllObjects];
    }
}
- (void)  addItem:(SHChatItem*)item
{
    @synchronized(mList){
        BOOL b = NO;
        for (SHChatItem * item2 in mList) {
            if([item2.questionid isEqualToString:item.questionid]){
                [mList removeObject:item2];
                item2.latestmessage = item.latestmessage;
                item2.asktime = item.asktime;
                [mList insertObject:item2 atIndex:0];
                b = YES;
                break;
            }
        }
        if(!b){
            [mList addObject:item];
        }
    }
//    NSData *studentData = [NSKeyedArchiver archivedDataWithRootObject:mList];
//    [[NSUserDefaults standardUserDefaults] setObject: studentData forKey:@"SHChatListHelper"];

}
@end
