//
//  SHChatItem.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-29.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatItem.h"

@implementation SHChatItem
@synthesize servicecategoryid;
@synthesize asktime;
@synthesize latestmessage;
@synthesize servicecategoryname;
@synthesize uploadpicture;
@synthesize isNew;
@synthesize questionid;
@synthesize problemdesc;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.problemdesc = [aDecoder decodeObjectForKey:@"problemdesc"];
        self.servicecategoryid = [aDecoder decodeObjectForKey:@"servicecategoryid"];
        self.questionid = [aDecoder decodeObjectForKey:@"questionid"];
        self.asktime = [aDecoder decodeObjectForKey:@"asktime"];
        self.latestmessage = [aDecoder decodeObjectForKey:@"latestmessage"];
        self.servicecategoryname = [aDecoder decodeObjectForKey:@"servicecategoryname"];
        self.uploadpicture = [aDecoder decodeObjectForKey:@"uploadpicture"];
        self.isNew = [[aDecoder decodeObjectForKey:@"isNew"] boolValue];
    }
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:problemdesc forKey:@"problemdesc"];
    [aCoder encodeObject:questionid forKey:@"questionid"];
    [aCoder encodeObject:servicecategoryid forKey:@"servicecategoryid"];
    [aCoder encodeObject:asktime forKey:@"asktime"];
    [aCoder encodeObject:latestmessage forKey:@"latestmessage"];
    [aCoder encodeObject:servicecategoryname forKey:@"servicecategoryname"];
    [aCoder encodeObject:uploadpicture  forKey:@"uploadpicture"];
    [aCoder encodeObject:[NSNumber numberWithBool:isNew] forKey:@"isNew"];
    
}

@end
