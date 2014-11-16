//
//  SHLineViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 14/11/15.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//
#import <Mapkit/Mapkit.h>

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

#import "SHLineViewController.h"

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end


@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface SHLineViewController ()<BMKRouteSearchDelegate,BNNaviUIManagerDelegate,BMKMapViewDelegate,BNNaviRoutePlanDelegate>
{
    BMKRouteSearch  *_searcher;
    BMKPlanNode* start ;
    BMKPlanNode* end;
    NSDictionary * dic;
}
@end

@implementation SHLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"线路";
    dic = [self.intent.args valueForKey:@"poi"];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:(BMKUserLocation*)[SHLocationManager instance].userlocation.source];
  
    _mapView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    [self showWaitDialog:@"正在搜索线路..." state:@"请稍后"];
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    start = [[BMKPlanNode alloc]init];
    start.pt = [SHLocationManager instance].userlocation.location.coordinate;
    end = [[BMKPlanNode alloc]init];
    end.pt = CLLocationCoordinate2DMake([[[dic valueForKey:@"baidulatitude"] valueForKey:@"lat"] floatValue], [[[dic valueForKey:@"baidulatitude"] valueForKey:@"lgt"] floatValue]);
    BMKDrivingRoutePlanOption *transitRouteSearchOption =         [[BMKDrivingRoutePlanOption alloc]init];
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_searcher drivingSearch:transitRouteSearchOption];
    
    float a = start.pt.latitude - end.pt.latitude;
    float b = start.pt.longitude - end.pt.longitude;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake((start.pt.latitude + end.pt.latitude)/2,(start.pt.longitude + end.pt.longitude)/2) animated:YES];
    BMKCoordinateRegion r;
    r.center = CLLocationCoordinate2DMake((start.pt.latitude + end.pt.latitude)/2,(start.pt.longitude + end.pt.longitude)/2) ;
    r.span.latitudeDelta = a;
    r.span.longitudeDelta = b;
    [_mapView setRegion:r animated:YES ];
    //- (void)setRegion:(BMKCoordinateRegion)region animated:(BOOL)animated;
  

    if(flag){
        NSLog(@"检索发送成功");
    }else{
        NSLog(@"检索发送失败");
    }
}

- (void)btnNavi:(UIBarButtonItem*)b
{
 NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
        //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
        BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
        startNode.pos = [[BNPosition alloc] init];
        startNode.pos.x = start.pt.longitude;
        startNode.pos.y = start.pt.latitude;
        startNode.pos.eType = BNCoordinate_BaiduMapSDK;
        [nodesArray addObject:startNode];
        
        //也可以在此加入1到3个的途经点
             //终点
        BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
        endNode.pos = [[BNPosition alloc] init];
        endNode.pos.x = end.pt.longitude;
        endNode.pos.y = end.pt.latitude;
        endNode.pos.eType = BNCoordinate_BaiduMapSDK;
        [nodesArray addObject:endNode];
        
        [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
        
        
    

}
#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        [self showAlertDialog:@"获取地理位置失败"];
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        [self showAlertDialog:@"定位服务未开启"];

        NSLog(@"定位服务未开启");
    }
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
       [self showAlertDialog:@"算路取消"];
}

//实现Deleage处理回调结果
-(void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:    (BMKTransitRouteResult*)result
                     errorCode:(BMKSearchErrorCode)error
{
    [self dismissWaitDialog];
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
          self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"导航" target:self action:@selector(btnNavi:)];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        //当路线起终点有歧义时通，获取建议检索起终点
        [self showAlertDialog:@"当路线起终点有歧义时通，获取建议检索起终点"];

        //result.routeAddrResult
    }
    else {
        NSLog(@"抱歉，未找到结果");
        [self showAlertDialog:@"未找到结果"];
    }
}


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"] ;
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            //            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            //            if (view == nil) {
            //                view = [[MKAnnotationView alloc]initWithAnnotation:(id <BMKAnnotation>)routeAnnotation reuseIdentifier:@"waypoint_node"];
            //                view.canShowCallout = TRUE;
            //            } else {
            //                [view setNeedsDisplay];
            //            }
            //
            //            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            //            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            //            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _mapView.delegate = nil ;
    _searcher.delegate = nil;
//    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nil time:nil delegete:nil userInfo:nil];
 //   [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:nil isNeedLandscape:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
