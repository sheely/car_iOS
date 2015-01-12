//
//  SHEditCarinfoViewViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/9/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHEditCarinfoViewViewController;

@protocol SHEditCarinfoViewViewControllerDelegate <NSObject>

- (void)editcarinfosubmit:(SHEditCarinfoViewViewController*)c;

@end

@interface SHEditCarinfoViewViewController : SHViewController<UITextFieldDelegate>

- (IBAction)btnCategaryOnTouch:(id)sender;
- (IBAction)btnSubCategaryOnTouch:(id)sender;
- (IBAction)btnProvinceOnTouch:(id)sender;
- (IBAction)btnLettersOnTouch:(id)sender;
- (IBAction)btnSubmitOnTouch:(id)sender;
- (IBAction)btnDeleteOnTouch:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnDelete;


@property (strong,nonatomic) NSMutableDictionary* carinfo;
@property (weak, nonatomic) IBOutlet UIButton *btnSubCategary;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIButton *btnCategary;
@property (weak, nonatomic) IBOutlet UIButton *btnProvince;
@property (weak, nonatomic) IBOutlet UIButton *btnLetters;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@end
