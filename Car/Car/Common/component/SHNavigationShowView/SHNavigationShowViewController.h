//
//  SHNavigationShowViewController.h
//  Zambon
//
//  Created by sheely on 13-9-7.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHViewController.h"

@protocol SHNavigationShowViewControllerDelegate <NSObject>

-(void)navigationShowControllerDidDissmiss;

@end

@interface SHNavigationShowViewController : SHViewController<UINavigationControllerDelegate>
{
    UINavigationController* mNavigationController;
    UIImageView * imgShade;
}

@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) id<SHNavigationShowViewControllerDelegate> delegate;

- (void)show : (UIViewController*)controller  frame:(CGRect) frame inView:(UIView*)view;
- (void)show : (UIViewController*)controller  frame:(CGRect) frame inView:(UIView*)view module :(BOOL) module;
- (void)show : (UIViewController*)controller;
- (void)dismiss;


@end
