//
//  SHIntentManager.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by WSheely on 14-3-5.
//  Copyright (c) 2014年 MobilityChina. All rights reserved.
//

#import "SHIntentManager.h"

@implementation SHIntentManager
static UINavigationController * __NAVIGATION__;

+ (void)btnCancel:(UIBarButtonItem*) btn
{
    [UIView setAnimationDuration:1];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = __NAVIGATION__.view.frame;
        rect.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height - rect.origin.y;
        __NAVIGATION__.view.frame = rect;
    } completion:^(BOOL finished) {
        [__NAVIGATION__.view removeFromSuperview];
        [__NAVIGATION__ popToRootViewControllerAnimated:NO];
        __NAVIGATION__ = nil;
    }];
   
}

+ (void)clear
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = __NAVIGATION__.view.frame;
        rect.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height - rect.origin.y;
        __NAVIGATION__.view.frame = rect;
    } completion:^(BOOL finished) {
        [__NAVIGATION__.view removeFromSuperview];
        [__NAVIGATION__ popToRootViewControllerAnimated:NO];
        __NAVIGATION__ = nil;
    }];

    
}
+ (void)open:(SHIntent *)intent
{
    if(intent.target){
        Class  class =  NSClassFromString(intent.target);
        NSObject * obj = Nil;
        if(class){
            obj = [[class alloc]init];
        }
        if([obj isKindOfClass:[SHViewController class]]){
            SHViewController * controller = (SHViewController*)obj;
            controller.intent = intent;
            NSString * error;
            BOOL bo = [controller checkIntent:error];
            if(bo){
                controller.delegate = intent.delegate;//delegate;
                if (intent.container){
                    if([intent.container isKindOfClass:[UINavigationController class]]){
                        UINavigationController * naviController = (UINavigationController*)intent.container;
                        [naviController pushViewController:controller animated:YES];
                    }
                }else if(__NAVIGATION__ == nil){
                    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCancel:self action:@selector(btnCancel:)];
                    __NAVIGATION__ = [[UINavigationController alloc]initWithRootViewController:controller];
                    
                    __NAVIGATION__.view.frame = [[UIScreen mainScreen]bounds];
                    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
                    [__NAVIGATION__.navigationBar setTitleTextAttributes:attributes];
                    __NAVIGATION__.navigationBar.translucent = NO;
                    
                    __NAVIGATION__.navigationBar.tintColor = [UIColor whiteColor];
                    if([UIImage imageNamed:@"ic_title"]){
                        [__NAVIGATION__.navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_title"] forBarMetrics:UIBarMetricsDefault];
                    }
                    if(!iOS7){
                        __NAVIGATION__.navigationBar.clipsToBounds = YES;
                    }
                    if([SHSkin.instance colorOfStyle:@"ColorBase"]!= nil && iOS7){
                        __NAVIGATION__.navigationBar.barTintColor = [SHSkin.instance colorOfStyle:@"ColorBase"];
                    }
                    [[UIApplication sharedApplication].keyWindow addSubview:__NAVIGATION__.view];
                    __NAVIGATION__.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCancel:self action:@selector(btnCancel:)];
                    CGRect rect = __NAVIGATION__.view.frame;
                    rect.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height;
                    __NAVIGATION__.view.frame = rect;
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        CGRect rect__=   rect;
                        rect__.origin.y = 0;
                        __NAVIGATION__.view.frame = rect__;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }else{
                SHContentViewController * errorController = [[SHContentViewController alloc]init];
                errorController.title = @"错误页面";
                if(error == nil){
                    errorController.content = @"参数错误";
                }else{
                    errorController.content = error;
                }
                if (intent.container){
                    if([intent.container isKindOfClass:[UINavigationController class]]){
                        UINavigationController * naviController = (UINavigationController*)intent.container;
                        [naviController pushViewController:errorController animated:YES];
                    }
                }else{
                    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:errorController];
                    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:errorController.view];
                }

            }
        }else {
            NSString * error;
            SHContentViewController * errorController = [[SHContentViewController alloc]init];
            errorController.title = @"错误页面";
            if(error == nil){
                errorController.content = @"不存在该页面";
            }else{
                errorController.content = error;
            }

            if (intent.container){
                if([intent.container isKindOfClass:[UINavigationController class]]){
                    UINavigationController * naviController = (UINavigationController*)intent.container;
                    [naviController pushViewController:errorController animated:YES];
                }
            }else{
                [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:errorController];
                [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:errorController.view];
            }

        }
    }
}
@end
