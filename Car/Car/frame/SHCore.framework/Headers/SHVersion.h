//
//  SHVersion.h
//  Core
//
//  Created by sheely.paean.Nightshade on 10/6/13.
//  Copyright (c) 2013 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHVersion : NSObject

@property (nonatomic,strong,readonly) NSArray * listver;

- (id)initWithString:(NSString*) version;

- (NSComparisonResult) compare :(SHVersion*)version;

@end
