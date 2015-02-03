//
//  SHNetReel.h
//  Core
//
//  Created by sheely.paean.Nightshade on 11/23/14.
//  Copyright (c) 2014 zywang. All rights reserved.
//

#import "SHObject.h"
#import "SHNetReel.h"

@protocol SHNetReelDelegate <NSObject>

- (void) processMsg :(SHResMsgM*)msg;

@end

@interface SHNetReel : NSObject

@property (weak,nonatomic) id<SHNetReelDelegate>delegate;

- (void)doRequest:(SHMsg*)msg;

@end
