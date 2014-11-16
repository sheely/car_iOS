//
//  SHShopListViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/24/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "BMKMapView.h"
#import <AVFoundation/AVFoundation.h>
#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "DataVerifier.h"
@interface SHShopListViewController : SHTableViewController<BMKMapViewDelegate,UIActionSheetDelegate,UITextFieldDelegate, BMKGeoCodeSearchDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIView *viewRequest;
@property (weak, nonatomic) IBOutlet UIImageView *imgBgView;
@property (weak, nonatomic) IBOutlet UIView *viewMapCollect;
@property (weak, nonatomic) IBOutlet UIView *viewCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnReserveCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnSound;
@property (weak, nonatomic) IBOutlet UIView *viewEnsure;
@property (weak, nonatomic) IBOutlet UIButton *btnEnsure;
@property (weak, nonatomic) IBOutlet UIView *viewPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UILabel *labLocation;
@property (weak, nonatomic) IBOutlet UIView *viewCategory;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIButton *btnTxt;
@property (nonatomic , retain) AVAudioPlayer *player;
- (IBAction)btnCheckOnTouch:(id)sender;
- (IBAction)btnAppointmentOnTouch:(id)sender;

- (IBAction)btnKeybord:(id)sender;
- (IBAction)btnLocationOnTouch:(id)sender;
- (IBAction)btnRecordUpInside:(id)sender;
- (IBAction)btnPlayOnTouch:(id)sender;
- (IBAction)btnRecordOutSide:(id)sender;
- (IBAction)btnRecordDown:(id)sender;
- (IBAction)btnPhotoOnTouch:(id)sender;
- (IBAction)btnEnsureOnTouch:(id)sender;
- (IBAction)btnTxtOnTouch:(id)sender;
- (IBAction)btnSearchLocationOnTouch:(id)sender;
@end
