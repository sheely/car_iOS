//
//  SHMsg.h
//  Core
//
//  Created by WSheely on 14-5-15.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHMsg : NSObject

@property (strong,nonatomic) NSString * guid   ;

//@property (strong,nonatomic) NSString * msgid;

- (NSData*) data;

@end
