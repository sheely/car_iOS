//
//  SHLoginViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/6/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHLoginViewController : SHViewController
@property (weak, nonatomic) IBOutlet UITextField *txtLoginName;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnCodeOnTouch:(id)sender;
- (IBAction)radiobuttonChanged:(id)sender;
- (IBAction)btnLoginPrivacyOnTouch:(id)sender;

@end
