//
//  SHImageViewController.m
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-24.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHImageViewController.h"

@interface SHImageViewController ()

@end

@implementation SHImageViewController

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
    if(self.intent){
        UIImage * img = [self.intent.args valueForKey:@"img"];
        self.title = [self.intent.args valueForKey:@"title"];
        if(img){
            self.imageView.image = img;
            CGRect rect = self.imageView.frame;
            rect.size.width = img.size.width;
            rect.size.height = img.size.height;
            self.imageView.frame = rect;
            ((UIScrollView*)self.view).contentSize = rect.size;
        }
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
