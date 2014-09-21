//
//  Command.h
//  Aroundme
//
//  Created by W Sheely on 13-2-6.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//


@interface Command : NSObject
@property (readonly,nonatomic)NSString* name;
@property (retain,nonatomic) NSArray* args;
- (void)description;
- (void)execute;
@end
