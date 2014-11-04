//
//  SHChatItem.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHChatItem : NSObject<NSCoding>
@property (copy,nonatomic) NSString* headicon;
@property (copy,nonatomic) NSString* userid;
@property (copy,nonatomic) NSString* username;
@property (copy,nonatomic) NSString* content;
@property (copy,nonatomic) NSString* date;
@property (assign,nonatomic) BOOL  isNew;
@end
