//
//  SHCleanViewCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHCleanViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewSpecial;

@property (weak, nonatomic) IBOutlet UILabel *labNormalOriginal;
@property (weak, nonatomic) IBOutlet UILabel *labNormalDiscount;
@property (weak, nonatomic) IBOutlet UILabel *labSpecialOriginal;
@property (weak, nonatomic) IBOutlet UILabel *labSpecialDiscount;
@property (strong,nonatomic) NSDictionary * dicInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnNormal;
@property (weak, nonatomic) IBOutlet UIButton *btnSpecial;
@property (assign,nonatomic) float summer;
- (IBAction)btnNormalOnTouch:(id)sender;
- (IBAction)btnSpecialOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnExtra;
- (IBAction)btnExtraOnTouch:(id)sender;
@end
