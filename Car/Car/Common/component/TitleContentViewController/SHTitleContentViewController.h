//
//  SHTitleContentViewController.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHViewController.h"
#import "SHContentViewController.h"

@interface SHTitleContentViewController :SHContentViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (strong,nonatomic) NSString * utitle;
@end
