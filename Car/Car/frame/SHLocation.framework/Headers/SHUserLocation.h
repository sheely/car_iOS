//
//  SHUserLocation.h
//  Core
//
//  Created by WSheely on 14-10-8.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLHeading.h>

typedef enum
{
    GPSTypeAPPLE = 0,
    GPSTYPEBAIDU = 1
}GPSType;

@interface SHUserLocation : NSObject


@property (nonatomic,strong) NSObject* source;
/// 位置更新状态，如果正在更新位置信息，则该值为YES

@property (assign,nonatomic) GPSType gpstype;

@property (nonatomic,assign) BOOL updating;

/// 位置信息，如果BMKMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil
@property (nonatomic,copy) CLLocation *location;

/// heading信息，如果BMKMapView的showsUserLocation为NO，或者尚未定位成功，则该值为nil
@property (nonatomic,copy) CLHeading *heading;

/// 定位标注点要显示的标题信息
@property (nonatomic,copy) NSString *title;

/// 定位标注点要显示的子标题信息.
@property (nonatomic,copy) NSString *subtitle;
@end
