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


typedef enum  {
    SHLocationFollowTypeContinue = 0,
    SHLocationFollowTypeTiming = 1
}SHLocationFollowType;

@interface SHLocationManager : NSObject<BMKLocationServiceDelegate>

{
    @private
    BMKLocationService *_bmkservice;
}

@property (assign,nonatomic) float timing;
@property (strong,nonatomic) SHUserLocation* userlocation;
@property (assign,nonatomic) SHLocationFollowType  followType;


- (void)startUserLocationService;

- (void)stopUserLocationService;

+ (SHLocationManager*)instance;
@end
