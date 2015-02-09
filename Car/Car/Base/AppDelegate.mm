//
//  AppDelegate.m
//  siemens_ios
//
//  Created by WSheely on 14-8-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "AppDelegate.h"
#import <sys/xattr.h>

@implementation AppDelegate

static NSString*  token = @"";

  CLLocationManager * locationManager;
BMKMapManager* _mapManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self addNotBackUp];
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    [ShareSDK registerApp:@"api20"];
    if(iOS8){
        locationManager =[[CLLocationManager alloc] init];
        [locationManager requestAlwaysAuthorization];//用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
    }
    
    _mapManager = [[BMKMapManager alloc]init];
    BMKMapView * v = [[BMKMapView alloc]init];
#if DEBUG
    BOOL ret = [_mapManager start:@"2GNPcYG9Kqfi3Up0bPGyvftD" generalDelegate:(id<BMKGeneralDelegate>)self];
#else
    BOOL ret = [_mapManager start:@"207KGwdrL9x8WDoHTFDeMqmS" generalDelegate:(id<BMKGeneralDelegate>)self];
#endif
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [MobClick startWithAppkey:@"54b23608fd98c5bf1400078a" reportPolicy:BATCH   channelId:@"Web"];

    // 初始化导航SDK引擎
#if DEBUG
    [BNCoreServices_Instance initServices:@"2GNPcYG9Kqfi3Up0bPGyvftD"];
#else
    [BNCoreServices_Instance initServices:@"207KGwdrL9x8WDoHTFDeMqmS"];
#endif
    [BNCoreServices_Instance startServicesAsyn:^{
        
    } fail:^{
        
    }];

    //开启引擎，传入默认的TTS类
//    [BNCoreServices_Instance startServicesAsyn:nil fail:nil SoundService:[BNaviSoundManager getInstance]];
    
    [SHLocationManager.instance startUserLocationService];

    
    if (iOS8) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];      }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];

    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#ifdef DEBUG
    [SHTask pull:URL_HEADER newUrl:BATA_HEADER];
#endif
//
    
    return YES;
}


-(void)addNotBackUp{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:documentsDirectory];
    
    [self addSkipBackupAttributeToItemAtURL:url];
    
    paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    url = [NSURL URLWithString:documentsDirectory];
    [self addSkipBackupAttributeToItemAtURL:url];

    
    
}
//设置云同步
-(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    
    return result == 0;
}


- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    token = [NSString stringWithFormat:@"%@", deviceToken];
#ifdef DEBUG
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您有一个新的消息." message:token delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
#endif
    NSLog(@"My token is:%@", token);
    if(SHEntironment.instance.loginName.length > 0){
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"loginupdate.action");
        [post.postArgs setValue:token forKey:@"appuuid"];
        [post start];
    }
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
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您有一个新的消息." message:userInfo[@"aps"][@"alert"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    NSString * noti = [userInfo valueForKey: @"type"];
    if(noti.length > 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:noti object:nil];
    }
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([url description].length > 14 && [[[url description] substringToIndex:14] isEqualToString:@"car://safepay/"]){
        NSString * order =  [[url description] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if([order rangeOfString:@"\"ResultStatus\" : \"9000\""].length > 0){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功." delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"取消" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alert show];
        }

        //[self performSelector:@selector(refreshOrder)withObject:nil afterDelay:1];
        [self performSelector:@selector(refreshOrder)withObject:nil afterDelay:3];
    }
    return YES;
}

- (void)refreshOrder
{
    [[NSNotificationCenter defaultCenter ] postNotificationName:@"notification_remain" object:@"order"];
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
