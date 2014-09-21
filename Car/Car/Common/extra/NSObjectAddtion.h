//
//  NSObjectAddtion.h
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-23.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject(sheely)

- (void)performSelector:(SEL)aSelector afterNotification:(NSString*) notification ;
@end
