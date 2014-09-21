//
//  CommandFactory.m
//  Aroundme
//
//  Created by sheely.paean.Nightshade on 2/14/13.
//  Copyright (c) 2013 dianping.com. All rights reserved.
//

#import "CommandFactory.h"


@implementation CommandFactory
+ (Command*) factoryByName:(NSString*)name{
    id  obj =   NSClassFromString(name);
    obj = [[obj alloc]init];
    if(obj != nil){
       
//        [obj alloc];
//        [obj initialize];
        //id command = class_create_instance(obj);
        if([obj isKindOfClass:[Command class]]){
           // if ([((NSObject*)obj) isKindOfClass: [Command class]]){
                return (Command*)obj;
            //}
        }
    }
    return nil;
}
@end
