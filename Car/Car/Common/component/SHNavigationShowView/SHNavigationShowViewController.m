//
//  SHNavigationShowViewController.m
//  Zambon
//
//  Created by sheely on 13-9-7.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHNavigationShowViewController.h"
#import "SHSkin.h"

@interface SHNavigationShowViewController ()

@end

@implementation SHNavigationShowViewController
@synthesize isShow;

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
   
    // Do any additional setup after loading the view from its nib.
}

- (void)createNavi
{
    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }
    mNavigationController = [[UINavigationController alloc]init];
    mNavigationController.navigationBar.translucent = NO;
    [mNavigationController.navigationBar setBackgroundImage:([[UIImage imageNamed:@"navigation_bar_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:10]) forBarMetrics:UIBarMetricsDefault];
    mNavigationController.navigationBar.backgroundColor = [UIColor clearColor];
    mNavigationController.navigationBar.tintColor = [UIColor clearColor];
    mNavigationController.navigationBar.clipsToBounds = YES;
    mNavigationController.delegate = self;
    //mNavigationController.view.backgroundColor = [UIColor clearColor];
    //mNavigationController.navigationBar.translucent = NO;
    [self.view addSubview:mNavigationController.view];
    CGRect imgShadeFrame = self.view.bounds;
    imgShadeFrame.origin.x = -5;
    imgShadeFrame.size.width= 8;
    if(imgShade == nil){
        imgShade = [[UIImageView alloc]initWithFrame:imgShadeFrame];
        imgShade.image = [SHSkin.instance stretchImage:@"showview_left_shade"];
    }
    imgShade.frame = imgShadeFrame;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:imgShade atIndex:0];

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL) animated
{
    if(mNavigationController.viewControllers.count == 1){
        UIViewController * controller =  [mNavigationController.viewControllers objectAtIndex:0];
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCancel :self action:@selector(btnBack:)];
    }else{
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [SHSkin.instance image:@"NaviBack.png" ] title:nil target:self action:@selector(popViewControllerAnimated)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" target: self action:@selector(popViewControllerAnimated)];
    }
}

- (void) popViewControllerAnimated
{
    [mNavigationController popViewControllerAnimated:YES];
}

- (void) btnBack:(NSObject * )object
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(navigationShowControllerDidDissmiss)]){
        [self.delegate navigationShowControllerDidDissmiss];
    }
    [self dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show : (UIViewController*)controller
{
    [self createNavi];
    [mNavigationController pushViewController:controller animated:NO];
}

- (void)show :(UIViewController*)controller  frame:(CGRect) frame inView:(UIView*)view
{
    if(self.isShow){
        return;
    }
    self.view.frame = frame;
    [self createNavi];
    self.view.alpha = 1;
    CGRect orRect = frame;
    orRect.origin.x = view.frame.size.width;
    self.view.frame = orRect;
    mNavigationController.view.frame = self.view.bounds;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = frame;
    [mNavigationController pushViewController:controller animated:YES];
    [view addSubview:self.view];
    [UIView commitAnimations];
    self.isShow = YES;
}

- (void)show :(UIViewController*)controller  frame:(CGRect) frame inView:(UIView*)view module :(BOOL) module
{
    if(self.isShow){
        return;
    }
    self.view.frame = frame;
  
    self.view.alpha = 1;
   
    UIView * bgView = [[UIView alloc]init];
    bgView.frame = self.view.bounds;
    bgView.autoresizingMask = (
                               UIViewAutoresizingFlexibleWidth       |
                               UIViewAutoresizingFlexibleHeight
                               );
    [self createNavi];
    [self.view insertSubview:bgView atIndex:0];

 
    CGRect orRect = frame;
    orRect.origin.x = view.frame.size.width;
    self.view.frame = view.bounds;
    bgView.alpha = 0;
    mNavigationController.view.frame = orRect;
    CGRect imgShadeFrame = orRect;
    imgShadeFrame.size.width = 10;
    imgShade.frame = imgShadeFrame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    bgView.alpha = 0.3;
    bgView.backgroundColor = [UIColor blackColor];

    mNavigationController.view.frame = frame;
    [mNavigationController pushViewController:controller animated:YES];
    imgShadeFrame = frame;
    imgShadeFrame.origin.x = -5 + imgShadeFrame.origin.x;
    imgShadeFrame.size.width= 5;
    imgShade.frame = imgShadeFrame;
//    [self.view addSubview:imgShade];
    [self.view insertSubview:imgShade belowSubview:mNavigationController.view];
    [view addSubview:self.view];
    [UIView commitAnimations];
    self.isShow = YES;
}

-(void)dismiss
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationDidStopSelector:@selector(btnAnimationDidStop)];
    self.view.alpha = 0;
    [self viewDidDisappear:YES];
    for (UIViewController * controller  in mNavigationController.viewControllers) {
        [controller viewDidDisappear:YES];
    }
    [UIView commitAnimations];
    self.isShow = NO;
}

- (void)btnAnimationDidStop
{
    [self.view removeFromSuperview];
}
@end
