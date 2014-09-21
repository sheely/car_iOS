//
//  SHPictureViewController.m
//  Zambon
//
//  Created by sheely on 13-12-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHPictureViewController.h"

@interface SHPictureViewController ()

@end

@implementation SHPictureViewController

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

- (void)loadSkin
{
    //[super loadSkin];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnImageOnTOuch:(id)sender
{
    self.view.alpha = 1;
    [UIView beginAnimations:Nil context:Nil];
    self.view.alpha = 0;
    [UIView setAnimationDuration:2];
    [UIView commitAnimations];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
}

- (void)animationDidStop
{
    [self.view removeFromSuperview];
}
- (void)showIn:(UIView *)view
{
    self.view.alpha = 0;
    [view addSubview:self.view];
    [UIView beginAnimations:nil context:nil  ];
    self.view.alpha = 1;
    [UIView setAnimationDuration:2];
    [UIView commitAnimations];
    
}
@end
