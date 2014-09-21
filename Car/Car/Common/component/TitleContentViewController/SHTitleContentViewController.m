//
//  SHTitleContentViewController.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTitleContentViewController.h"

@interface SHTitleContentViewController ()

@end

@implementation SHTitleContentViewController
@synthesize utitle;
@synthesize content;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)checkIntent:(NSString*)error
{
    if(self.intent){
        self.utitle = [self.intent.args valueForKey:@"utitle"];
        self.title = [self.intent.args valueForKey:@"title"];
        self.content =  [self.intent.args valueForKey:@"content"];
        return YES;
    }else{
        return NO;
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.labTitle.text = self.utitle;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSkin
{
    [super loadSkin];
    self.labTitle.userstyle = @"lablargedark";
  
}



@end
