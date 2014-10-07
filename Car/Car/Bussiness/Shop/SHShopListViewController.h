//
//  SHShopListViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/24/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "BMKMapView.h"

@interface SHShopListViewController : SHTableViewController<BMKMapViewDelegate>
{
    BMKLocationService* _locService;

}
@property (weak, nonatomic) IBOutlet UIView *viewMapCollect;
@property (weak, nonatomic) IBOutlet UIView *viewCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnReserveCheck;
@end
