//
//  SHObject.h
//  Core
//
//  Created by zywang on 13-8-17.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHObject : NSObject


- (int) integerForKey:(NSString*) key;
- (double)doubleForKey:(NSString*)key;
- (SHObject*) objForKey:(NSString*)key;
- (NSArray*) listForKey:(NSString*)key;
@end
