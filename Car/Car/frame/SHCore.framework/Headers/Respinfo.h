//
//  state.h
//  Core
//
//  Created by sheely on 13-9-13.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Respinfo : NSObject

@property (nonatomic,strong,readonly) NSString * message;
@property (nonatomic,assign,readonly) int code;


- (id)initWithCode:(int)code message:(NSString*)message;

- (void) show;
@end

