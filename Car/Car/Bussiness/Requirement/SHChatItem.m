//
//  SHChatItem.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatItem.h"

@implementation SHChatItem
@synthesize headicon;
@synthesize userid;
@synthesize username;
@synthesize content;
@synthesize date;
@synthesize isNew;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.headicon = [aDecoder decodeObjectForKey:@"headicon"];
        self.userid = [aDecoder decodeObjectForKey:@"userid"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.isNew = [[aDecoder decodeObjectForKey:@"isNew"] boolValue];
    }
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:headicon forKey:@"headicon"];
    [aCoder encodeObject:userid forKey:@"userid"];
    [aCoder encodeObject:username forKey:@"username"];
    [aCoder encodeObject:content forKey:@"content"];
    [aCoder encodeObject:date forKey:@"date"];
    [aCoder encodeObject:[NSNumber numberWithBool:isNew] forKey:@"isNew"];
    
}

@end
