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

@interface SHShopListViewController : SHTableViewController<BMKMapViewDelegate,UIActionSheetDelegate,BMKGeoCodeSearchDelegate>
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
@property (weak, nonatomic) IBOutlet UILabel *labTest;
@property (weak, nonatomic) IBOutlet UILabel *labLocation;
@property (nonatomic , retain) AVAudioPlayer *player;

- (IBAction)btnLocationOnTouch:(id)sender;
- (IBAction)btnRecordUpInside:(id)sender;
- (IBAction)btnPlayOnTouch:(id)sender;
- (IBAction)btnRecordOutSide:(id)sender;
- (IBAction)btnRecordDown:(id)sender;
- (IBAction)btnPhotoOnTouch:(id)sender;
- (IBAction)btnEnsureOnTouch:(id)sender;
- (IBAction)btnSearchLocationOnTouch:(id)sender;
@end
