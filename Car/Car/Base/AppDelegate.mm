//
//  AppDelegate.m
//  siemens_ios
//
//  Created by WSheely on 14-8-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "AppDelegate.h"
#import "BNaviSoundManager.h"
@implementation AppDelegate
  CLLocationManager * locationManager;
BMKMapManager* _mapManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    [ShareSDK registerApp:@"api20"];
    if(iOS8){
        
    locationManager =[[CLLocationManager alloc] init];
    
//  [locationManager requestAlwaysAuthorization];//用这个方法，plist中需要NSLocationAlwaysUsageDescription
    
    [locationManager requestAlwaysAuthorization];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
    }
    
    _mapManager = [[BMKMapManager alloc]init];
    BMKMapView * v = [[BMKMapView alloc]init];
    BOOL ret = [_mapManager start:@"2GNPcYG9Kqfi3Up0bPGyvftD" generalDelegate:(id<BMKGeneralDelegate>)self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // 初始化导航SDK引擎
    [BNCoreServices_Instance initServices:@"2GNPcYG9Kqfi3Up0bPGyvftD"];
    
    //开启引擎，传入默认的TTS类
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil SoundService:[BNaviSoundManager getInstance]];
    
    [SHLocationManager.instance startUserLocationService];

    return YES;
}
- (void)onGetNetworkState:(int)iError
{
}

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError
{
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
