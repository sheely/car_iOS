//
//  SHWebViewController.m
//  siemens_ios
//
//  Created by WSheely on 14-9-9.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHWebViewController.h"

@interface SHWebViewController ()

@end

@implementation SHWebViewController

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
    if([self.intent.args valueForKey:@"url"]){
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.intent.args valueForKeyPath:@"url"]]]];
    }
    self.webView.scalesPageToFit = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
