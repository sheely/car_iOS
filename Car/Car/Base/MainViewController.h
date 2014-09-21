//
//  MainViewController.h
//  siemens_ios
//
//  Created by WSheely on 14-8-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHViewController.h"
#import <UIKit/UIKit.h>

@interface MainViewController : SHViewController <UITabBarDelegate>
{
    __weak IBOutlet UITabBar *tabbar;
    __weak IBOutlet UIView *mark;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; // called when a new view is selected by the user (but not programatically)

@end
