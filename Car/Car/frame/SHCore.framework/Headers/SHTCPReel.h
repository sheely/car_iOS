//
//  SHTCPReel.h
//  Core
//
//  Created by sheely.paean.Nightshade on 11/23/14.
//  Copyright (c) 2014 zywang. All rights reserved.
//

#import "SHObject.h"

@interface SHTCPReel : SHNetReel
{
    GCDAsyncSocket * mSocket;
}
@property (copy,nonatomic) NSString* ipAddress;
@property (assign,nonatomic) BOOL isWorking;

@property (assign,nonatomic) int port;

- (void)connect : (NSString*) address port:(int) port;

@end
