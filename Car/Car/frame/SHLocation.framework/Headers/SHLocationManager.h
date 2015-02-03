//
//  SHLocationManager.h
//  Core
//
//  Created by WSheely on 14-10-8.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
#import "SHUserLocation.h"

@interface SHLocationManager : NSObject<BMKLocationServiceDelegate>

{
    @private
    BMKLocationService *_bmkservice;
}

@property (strong,nonatomic) SHUserLocation* userlocation;

- (void)startUserLocationService;

- (void)stopUserLocationService;

+ (SHLocationManager*)instance;
@end
