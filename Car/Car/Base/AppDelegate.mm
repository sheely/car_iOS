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

static NSString*  token = @"";

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

    
    if (iOS8) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];      }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];

    }
    
    //判断是否由远程消息通知触发应用程序启动
    if (launchOptions) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
            NSDictionary *pushInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
            
            //获取推送详情
            NSString *pushString = [NSString stringWithFormat:@"%@",[pushInfo  objectForKey:@"aps"]];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"finish Loaunch" message:pushString delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    
    return YES;
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is:%@", token);
    //这里应将device token发送到服务器端
}

+ (NSString*)token
{
    return token;
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    for (id key in userInfo) {
        NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    /* eg.
     key: aps, value: {
     alert = "\U8fd9\U662f\U4e00\U6761\U6d4b\U8bd5\U4fe1\U606f";
     badge = 1;
     sound = default;
     }
     */
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"remote notification" message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
    [alert show];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([url description].length > 14 && [[[url description] substringToIndex:14] isEqualToString:@"car://safepay/"]){
        [self performSelector:@selector(refreshOrder)withObject:nil afterDelay:5];
    }
    return YES;
}

- (void)refreshOrder
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE_ORDER object:nil];
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
