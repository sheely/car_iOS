//
//  SHMainPageViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHMainPageViewController : SHViewController
{
    __weak IBOutlet SHImageView *imgBrand;
    __weak IBOutlet UILabel *labBrand;
    __weak IBOutlet UILabel *labCardNo;
    __weak IBOutlet UIScrollView *scrollview;

}
- (IBAction)btnSupportOnTouch:(id)sender;
- (IBAction)btnRepair:(id)sender;
- (IBAction)btnInsuranceOnTouch:(id)sender;
- (IBAction)btnMoreOnTouch:(id)sender;
- (IBAction)btnCleanOnTouch:(id)sender;
- (IBAction)btnCheckOnTouch:(id)sender;
- (IBAction)btnCarManageOnTouch:(id)sender;
- (IBAction)btnTabOnTouch:(id)sender;
@end
