//
//  SHCheckOrderView.h
//  Car
//
//  Created by sheely.paean.Nightshade on 11/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHView.h"

@class SHCheckOrderView;

@protocol SHCheckOrderViewDelegate <NSObject>

-(void)checkorderviewOnSubmit:(SHCheckOrderView*)view;

@end

@interface SHCheckOrderView : SHView
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (strong,nonatomic) NSDictionary * checkticket;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UILabel *labCoupon;
@property (weak, nonatomic) IBOutlet UIView *viewCoupon;
@property (weak, nonatomic) IBOutlet UIButton *btnCoupon;
@property (weak,nonatomic) id<SHCheckOrderViewDelegate> delegate;
- (IBAction)btnCouponOnTouch:(id)sender;
- (IBAction)btnSubmitOnTouch:(id)sender;

- (IBAction)btnCloseOnTouch:(id)sender;
@end
