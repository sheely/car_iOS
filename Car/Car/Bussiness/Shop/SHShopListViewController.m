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
#import "SHShopPointAnnotation.h"

@interface SHShopListViewController ()

@end

@implementation SHShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户列表";
    self.mapView.delegate = self;
   
    //[self startFollowing:nil];
    if([[self.intent.args valueForKey:@"type"] isEqualToString:@"clean"]){
        self.tableView.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_map"] target:self action:@selector(checkListMap)];
        self.viewMapCollect.hidden = YES;
        self.viewCheck.hidden = YES;
    }else{
        self.tableView.hidden = YES;
        self.viewCheck.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_list"] target:self action:@selector(checkListMap)];
    }
    [self startLocation:nil];
    [_mapView updateLocationData:[SHLocationManager instance].userlocation.source];
    [_mapView setCenterCoordinate:[SHLocationManager instance].userlocation.location.coordinate animated:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:CORE_NOTIFICATION_LOCATION_UPDATE_USERLOCATION object:nil];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)updateLocation:(NSNotification*)n
{
    [_mapView updateLocationData:[SHLocationManager instance].userlocation.source];
}

- (void)checkListMap
{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations];
    if(!self.tableView.hidden ){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_list"] target:self action:@selector(checkListMap)];
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_map"] target:self action:@selector(checkListMap)];
    }
    
    
    self.tableView.hidden = ! self.tableView.hidden;
    self.viewMapCollect.hidden = ! self.viewMapCollect.hidden;
    
}

- (void)loadSkin
{
    [super loadSkin];
    self.btnCheck.layer.masksToBounds = YES;
    self.btnCheck.layer.cornerRadius = 5;
    self.btnReserveCheck.layer.masksToBounds = YES;
    self.btnReserveCheck.layer.cornerRadius = 5;
    self.tableView.backgroundColor = [UIColor whiteColor];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNext
{
    
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    task.URL= URL_FOR(@"shopquery.action");
    [task.postArgs setValue:@"" forKey:@"keyname"];
    [task.postArgs setValue:[NSNumber numberWithFloat: SHLocationManager.instance.userlocation.location.coordinate.latitude]  forKey:@"lat"];
    [task.postArgs setValue:[NSNumber numberWithFloat: SHLocationManager.instance.userlocation.location.coordinate.longitude] forKey:@"lgt"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"pageno"];
    [task.postArgs setValue:[NSNumber numberWithFloat:20] forKey:@"pagesize"];

    [task start:^(SHTask *t) {
        mList = [t.result valueForKey:@"nearshops"];
        mIsEnd = YES;
        
        for (NSDictionary * m in mList) {
            SHShopPointAnnotation* pointAnnotation = [[SHShopPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [[[m valueForKey:@"originallatitude"] valueForKey:@"lat"] floatValue];
            coor.longitude = [[[m valueForKey:@"originallatitude"] valueForKey:@"lgt"] floatValue];
            pointAnnotation.coordinate = coor;
            pointAnnotation.title = @"test";
            pointAnnotation.subtitle = @"此Annotation可拖拽!";
            pointAnnotation.dic = m;
            [_mapView addAnnotation:pointAnnotation];
        }
        
        [self.tableView reloadData];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    NSDictionary * dic = ((SHShopPointAnnotation*)annotation).dic;
    SHShopPinAnnotationView* newAnnotation = [[[NSBundle mainBundle]loadNibNamed:@"SHShopPinAnnotationView" owner:nil options:nil] objectAtIndex:0];
    newAnnotation.annotation = annotation;
    [newAnnotation.btnAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    newAnnotation.labTitle.text = [dic valueForKey:@"shopname"];
    newAnnotation.labAddress.text = [dic valueForKey:@"shopaddress"];
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
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHShopListCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHShopListCell" owner:nil options:nil] objectAtIndex:0];
    cell.labShopName.text = [dic valueForKey:@"shopname"];
    cell.labAddress.text = [dic valueForKey:@"shopaddress"];
    cell.labDistance.text = [NSString stringWithFormat:@"距离:%@",[dic valueForKey:@"distancefromme"]];
    cell.labPrice.text = [NSString stringWithFormat:@"普洗:%@元",[dic valueForKey:@"normalwashoriginalprice"]];
    cell.labNewPrice.text = [NSString stringWithFormat:@"精洗:%@元",[dic valueForKey:@"normalwashdiscountprice"]];

    cell.backgroundColor= [UIColor whiteColor];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHIntent * i =  [[SHIntent alloc]init:@"shopinfo" delegate:nil containner:self.navigationController];
    [i.args setValue:[dic valueForKey:@"shopid"] forKey:@"shopid"];
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

- (IBAction)btnLocationOnTouch:(id)sender {
    [_mapView updateLocationData:[SHLocationManager instance].userlocation.source];
    [_mapView setCenterCoordinate:[SHLocationManager instance].userlocation.location.coordinate animated:YES];
}
@end
