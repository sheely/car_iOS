//
//  SHContentViewController.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely.paean.Nightshade on 10/31/13.
//  Copyright (c) 2013 MobilityChina. All rights reserved.
//

#import "SHContentViewController.h"

@interface SHContentViewController ()

@end

@implementation SHContentViewController

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
        self.title = [self.intent.args valueForKey:@"title"];
        self.content =  [self.intent.args valueForKey:@"content"];
        return YES;
    }else{
        return NO;
    }
    
}
- (void)loadSkin
{
    [super loadSkin];
    self.txtContent.userstyle = @"labmiddark";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtContent.text = self.content;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
