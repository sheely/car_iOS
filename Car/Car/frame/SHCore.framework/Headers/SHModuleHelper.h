//
//  SHModuleHelper.h
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-23.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface  SHModule :NSObject{
@public
    NSString * name;
    NSString * need_pre_action;
    NSString * pre_action;
    NSString * target ;
    NSString * icon;
    NSString * type;
    NSString * title;
}
@end
@interface SHModuleHelper : NSObject

- (NSString * )targetByModule:(NSString*) modulename;

- (NSString * )targeByPreAction:(NSString*) action;

- (NSArray * )modulelist ;

+ (SHModuleHelper*) instance;
@end
