//
//  SHChatItem.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHChatItem : NSObject<NSCoding>

@property (copy,nonatomic) NSString* questionid;
@property (copy,nonatomic) NSString* problemdesc;

@property (copy,nonatomic) NSString* servicecategoryid;
@property (copy,nonatomic) NSString* asktime;
@property (copy,nonatomic) NSString* latestmessage;
@property (copy,nonatomic) NSString* servicecategoryname;
@property (copy,nonatomic) NSString* uploadpicture;
@property (assign,nonatomic) BOOL  isNew;
@end
