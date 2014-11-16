//
//  SHCarInfoViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHCarInfoViewController : SHViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UIView *viewDashBoard;
@property (weak, nonatomic) IBOutlet UIImageView *imgIndicator;
@property (weak, nonatomic) IBOutlet UILabel *labScore;
@property (weak, nonatomic) IBOutlet UIView *viewCarControl;
@property (weak, nonatomic) IBOutlet UIView *viewSafety;
@property (weak, nonatomic) IBOutlet UIView *viewOil;
@property (weak, nonatomic) IBOutlet UIView *view4Itmes;
@property (weak, nonatomic) IBOutlet UILabel *labState1;
@property (weak, nonatomic) IBOutlet UIImageView *btnGesture;
@property (strong, nonatomic) IBOutlet UIView *viewNeedCheck;

@property (weak, nonatomic) IBOutlet UIView *viewPower;
@property (weak, nonatomic) IBOutlet UIButton *btnPower;
- (IBAction)btnOilOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckReport;
@property (weak, nonatomic) IBOutlet UIButton *btnNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnRepair;
@property (weak, nonatomic) IBOutlet UIButton *btnCarState;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imgBgBlue;
@property (weak, nonatomic) IBOutlet SHImageView *imgCarLogo;
@property (weak, nonatomic) IBOutlet UIImageView *imgCar;
@property (weak, nonatomic) IBOutlet UILabel *labBand;
@property (weak, nonatomic) IBOutlet UILabel *labCarId;
@property (weak, nonatomic) IBOutlet UILabel *labState2;
@property (weak, nonatomic) IBOutlet UILabel *labState4;
@property (weak, nonatomic) IBOutlet UILabel *labState3;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
- (IBAction)btnBackOnTouch:(id)sender;
- (IBAction)btnCheckOnTouch:(id)sender;
- (IBAction)btnRepairOnTouch:(id)sender;
- (IBAction)btnCheckReportOnTouch:(id)sender;
- (IBAction)btnContinueDemoOnTouch:(id)sender;
- (IBAction)btnNodificationOnTouch:(id)sender;
- (IBAction)btnCarStateOnTouch:(id)sender;
@end
