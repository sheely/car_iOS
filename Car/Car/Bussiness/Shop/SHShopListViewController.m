//
//  SHShopListViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/24/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopListViewController.h"
#import "SHShopListCell.h"
#import "SHShopPinAnnotationView.h"

@interface SHShopListViewController ()

@end

@implementation SHShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户列表";
    self.mapView.delegate = self;
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    [self startFollowing:nil];
    [self addPointAnnotation];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnCheck.layer.masksToBounds = YES;
    self.btnCheck.layer.cornerRadius = 5;
    self.btnReserveCheck.layer.masksToBounds = YES;
    self.btnReserveCheck.layer.cornerRadius = 5;
}

- (void)addPointAnnotation
{
    BMKPointAnnotation* pointAnnotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
    
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 39.7151;
    coor.longitude = 116.4011;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 39.7151;
    coor.longitude = 116.4011;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
    
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 31.1408;
    coor.longitude = 121.5709;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
   
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 31.1008;
    coor.longitude = 121.5209;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
   
    pointAnnotation = [[BMKPointAnnotation alloc]init];
    coor.latitude = 31.0108;
    coor.longitude = 121.5109;
    pointAnnotation.coordinate = coor;
    pointAnnotation.title = @"test";
    pointAnnotation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:pointAnnotation];
    
}
-(IBAction)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
 }

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNext
{
    mIsEnd = YES;
    mList =[ @[@"",@"",@"",@"",@"",@""]mutableCopy ] ;
    [self.tableView reloadData];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    SHShopPinAnnotationView* newAnnotation = [[[NSBundle mainBundle]loadNibNamed:@"SHShopPinAnnotationView" owner:nil options:nil] objectAtIndex:0];
    newAnnotation.annotation = annotation;
    [newAnnotation.btnAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //newAnnotation.reuseIdentifier = AnnotationViewID;
    NSString *AnnotationViewID = @"renameMark";

//BMKPinAnnotationView *  newAnnotation =    [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    newAnnotation.centerOffset = CGPointMake(1000, -100);

    // 设置颜色
//    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
    ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
    // 设置可拖拽
    //((BMKPinAnnotationView*)newAnnotation).draggable = YES;
return newAnnotation;

}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHShopListCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHShopListCell" owner:nil options:nil] objectAtIndex:0];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * i =  [[SHIntent alloc]init:@"shopinfo" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];
}
- (void)btnAction:(UIButton*)sender
{
    SHIntent * i =  [[SHIntent alloc]init:@"shopinfo" delegate:nil containner:self.navigationController];
    [[UIApplication sharedApplication]open:i];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
