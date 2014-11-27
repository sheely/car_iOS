//
//  MainViewController.m
//  siemens_ios
//
//  Created by WSheely on 14-8-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()
{
    NSMutableArray * list ;
    NSMutableArray * sublist ;
    UITabBarItem *mItem;
    NSMutableDictionary * mDictionary ;
    
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_LOGIN_SUCCESSFUL object:nil];
    mDictionary  = [[NSMutableDictionary alloc]init];
      NSArray * array = [SHModuleHelper  instance].modulelist;
    list = [[NSMutableArray alloc]init];
    sublist = [[NSMutableArray alloc]init];
    
    for (SHModule* module in array) {
        if([module->type isEqualToString:@"main"]){
            [list addObject:module];
        }
    }
    for (SHModule* module in array) {
        if([module->type isEqualToString:@"general"]){
            if(list.count >= 4){
                [sublist addObject:module];
            }else{
                [list addObject:module];
            }
        }
    }
    NSMutableArray * listtab = [[NSMutableArray alloc]init];
    for (int i= 0 ; i < list.count ; i++) {
        SHModule* module = [list objectAtIndex:i];
        UITabBarItem * item = [[UITabBarItem alloc]init];
        item.title = module->title;
        item.tag = i;
        item.image = [UIImage imageNamed:module->icon];
        [listtab addObject:item];
    }
    if(sublist.count > 0){
        UITabBarItem * item = [[UITabBarItem alloc]init];
        item.title = @"更多";
        item.tag = list.count;
        item.image = [UIImage imageNamed:@"tab_news.png"];
        [listtab addObject:item];
    }
    [tabbar setSelectedImageTintColor:[SHSkin.instance colorOfStyle:@"ColorNavigation"]];
    tabbar.items = listtab;
    tabbar.selectedItem = [tabbar.items objectAtIndex:0];
    [self tabBar:tabbar didSelectItem:tabbar.selectedItem];

    // Do any additional setup after loading the view from its nib.
}

- (void)notification:(NSObject*)sender
{
        [self tabBar:tabbar didSelectItem:[tabbar.items objectAtIndex:0]];
        tabbar.selectedItem = [tabbar.items objectAtIndex:0];
        [self tabBar:tabbar didSelectItem:tabbar.selectedItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    mItem = item;
    //[self performSelector:@selector(tabChanged) afterNotification:@"notification_login_successful"];
    [self tabChanged];
}// called when a new view is selected by the user (but not programatically)

- (void)tabChanged
{
    
    CGRect rect = self.view.bounds;
    rect.size.height -= 50;
    UINavigationController * controller  ;
    if(mItem.tag >= list.count){
        NSMutableArray*  kesublist = [[NSMutableArray alloc]init];
        
        for (int i = 0; i< sublist.count; i++) {
            SHModule* module = [sublist objectAtIndex:i];
            KxMenuItem * ke = [[KxMenuItem alloc]init];
            ke.title = module->title;
            ke.target = self;
            ke.tag = i;
            ke.action = @selector(KxMenuItemOnTouch:);
            [kesublist addObject:ke];
        }
        [KxMenu showMenuInView:self.view fromRect:mark.frame menuItems:kesublist];
        
        return;
        
        
    }else{
        SHModule * module = [list objectAtIndex:mItem.tag];
        controller = [mDictionary objectForKey:module->target];
        if(controller == nil){
            
            controller = [[UINavigationController alloc]initWithRootViewController: [[NSClassFromString(module->target) alloc]init]];
            [mDictionary setObject:controller forKey:module->target];
            //[controller.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
            [controller.navigationBar setBarTintColor:[SHSkin.instance colorOfStyle:@"ColorNavigation"]];
            [controller.navigationBar setBarStyle:UIBarStyleBlack];
            //controller.navigationBar.clipsToBounds = YES;
            
        }
    }
    controller.navigationBar.translucent = NO;
    if(!iOS7){
        controller.navigationBar.clipsToBounds = YES;
    }
    //mNavigationController.tabBarController.translucent = NO;
    [curviewcontroller.view removeFromSuperview];
    curviewcontroller = controller;
    controller.view.frame = rect;
    [self.view addSubview:controller.view];
}

- (void)KxMenuItemOnTouch:(KxMenuItem*)item
{
    CGRect rect = self.view.bounds;
    rect.size.height -= 50;
    UINavigationController * controller  ;
    
    SHModule * module = [sublist objectAtIndex:item.tag];
    controller = [mDictionary objectForKey:module->target];
    if(controller == nil){
        
        controller = [[UINavigationController alloc]initWithRootViewController: [[NSClassFromString(module->target) alloc]init]];
        [mDictionary setObject:controller forKey:module->target];
        [controller.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg.png"] forBarMetrics:UIBarMetricsDefault];
        [controller.navigationBar setBarStyle:UIBarStyleBlack];
        //controller.navigationBar.clipsToBounds = YES;
        
    }
    
    controller.navigationBar.translucent = NO;
    if(!iOS7){
        controller.navigationBar.clipsToBounds = YES;
    }
    //mNavigationController.tabBarController.translucent = NO;
    controller.view.frame = rect;
    [curviewcontroller.view removeFromSuperview];
    curviewcontroller = controller;
    [self.view addSubview:controller.view];
    
}
@end
