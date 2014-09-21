//
//  SHShowViewController.m
//  Zambon
//
//  Created by sheely on 13-9-5.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHShowViewController.h"

@interface SHShowViewController ()

@end

@implementation SHShowViewController
@synthesize title;
@synthesize labTitle = mLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setTitle:(NSString *)title_
{
    mLabel.text = title_;
}

- (void)viewDidLoad
{
    UIImageView * img = [[UIImageView alloc]initWithFrame:self.view.bounds];
    img.autoresizingMask = (
                            UIViewAutoresizingFlexibleWidth|
                            UIViewAutoresizingFlexibleHeight
                            );
    img.image = [[UIImage imageNamed:@"login_input_background"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.view insertSubview:img atIndex:0];
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 43, self.view.frame.size.width , 1);
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    CGRect rect = self.view.bounds;
    rect.size.height = 44;
    if(mLabel == nil){
        mLabel = [[UILabel alloc]init];
        mLabel.frame =rect;
        [self.view addSubview:mLabel];
        mLabel.backgroundColor = [UIColor clearColor];
        mLabel.autoresizingMask = (
                                   UIViewAutoresizingFlexibleWidth
                                   );
    }
 

    //[self.view insertSubview:mLabel aboveSubview:img];
   
    UIImageView * imglogo = [[UIImageView alloc]initWithFrame:self.view.bounds];

    imglogo.image = [UIImage imageNamed:@"main_frame_background_logo"];
    imglogo.frame = CGRectMake(600, 450, 175, 48);
    [self.view addSubview:imglogo];
     
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor clearColor];
  	// Do any additional setup after loading the view.
}

- (void)loadSkin
{
    //[super loadSkin];
    self.view.backgroundColor = [UIColor clearColor];
    mLabel.userstyle = @"labmiddark";
    mLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
