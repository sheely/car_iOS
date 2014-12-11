//
//  AppDelegate.h
//  siemens_ios
//
//  Created by WSheely on 14-8-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : SHAppDelegate <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
+ (NSString*)token;
@end
