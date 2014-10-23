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
#import "LCVoice.h"
#import "SHPhoto.h"
#import "SHSelectLocationAnnotationView.h"
@interface SHShopListViewController ()
{
    LCVoice * voice ;
    NSMutableArray * mListPhoto;
    BMKGeoCodeSearch * _searcher;
    SHShopPointAnnotation* selectLocation;
}
@end

@implementation SHShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = self.view.bounds;
    self.title = @"商户列表";
    self.mapView.delegate = self;
    voice = [[LCVoice alloc]init];
    //[self startFollowing:nil];
    if([[self.intent.args valueForKey:@"type"] isEqualToString:@"clean"]){
        self.tableView.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_map"] target:self action:@selector(checkListMap)];
        self.viewMapCollect.hidden = YES;
        self.viewCheck.hidden = YES;
        self.viewRequest.hidden = YES;
    }else if([[self.intent.args valueForKey:@"type"] isEqualToString:@"check"]){
        self.tableView.hidden = YES;
        self.viewCheck.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_list"] target:self action:@selector(checkListMap)];
    }else if ([[self.intent.args valueForKey:@"type"] isEqualToString:@"consultation"]){
        self.tableView.hidden = YES;
        self.viewCheck.hidden = YES;
        self.imgBgView.hidden = NO;
        self.viewRequest.hidden = NO;
        self.labTest.text = @"汽车美容";
    }else {
        if([[self.intent.args valueForKey:@"type"]isEqualToString:@"repair"]){
            self.labTest.text = @"钣金维修";
        }else if([[self.intent.args valueForKey:@"type"]isEqualToString:@"support"]){
            self.labTest.text = @"拖车服务";
        }
        else if([[self.intent.args valueForKey:@"type"]isEqualToString:@"Insurance"]){
            self.labTest.text = @"汽车保险";
        }
        
        self.tableView.hidden = YES;
        self.viewCheck.hidden = YES;
        self.viewRequest.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_list"] target:self action:@selector(checkListMap)];

    }
    if([self.intent.args valueForKey:@"title"]){
        self.title = [self.intent.args valueForKey:@"title"];
    }
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:(BMKUserLocation*)[SHLocationManager instance].userlocation.source];
    [_mapView setCenterCoordinate:[SHLocationManager instance].userlocation.location.coordinate animated:YES];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocation:) name:CORE_NOTIFICATION_LOCATION_UPDATE_USERLOCATION object:nil];
    mListPhoto = [[NSMutableArray alloc]init];
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = SHLocationManager.instance.userlocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    //[self showWaitDialog:@"正在请求地址信息..." state:@"请稍后..."];
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    //[reverseGeoCodeSearchOption release];
    if(flag){
        NSLog(@"反geo检索发送成功");
    }
    else{
        NSLog(@"反geo检索发送失败");
    }
    selectLocation = [[SHShopPointAnnotation alloc]init];

    selectLocation.coordinate = _mapView.centerCoordinate;//SHLocationManager.instance.userlocation.location.coordinate;
    selectLocation.title = @"当前点";
    selectLocation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:selectLocation];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    [self dismissWaitDialog];
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        self.labLocation.text = [NSString stringWithFormat:@"当前位置:%@",result.address];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)updateLocation:(NSNotification*)n
{
    [_mapView updateLocationData:(BMKUserLocation*)[SHLocationManager instance].userlocation.source];
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
    self.btnSound.layer.masksToBounds = YES;
    self.btnSound.layer.cornerRadius = 5;
    self.btnSearchLocation.layer.cornerRadius = 5;
    self.btnSearchLocation.layer.masksToBounds = YES;
    self.btnEnsure.layer.masksToBounds = YES;
    self.btnEnsure.layer.cornerRadius = 5;
    self.btnPlay.layer.masksToBounds = YES;
    self.btnPlay.layer.cornerRadius = 5;
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (IBAction)btnRecordUpInside:(id)sender
{
    [self recordEnd];
}

- (IBAction)btnRecordOutSide:(id)sender
{
    [self recordCancel];
}

- (IBAction)btnRecordDown:(id)sender
{
    [self recordStart];
}

- (IBAction)btnPhotoOnTouch:(id)sender
{
    if(mListPhoto.count > 2){
        [self showAlertDialog:@"最多上传3张图片."];
        return;
    }
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}

- (IBAction)btnEnsureOnTouch:(id)sender
{
    [self showAlertDialog:@"需求发布成功!"];
    [self closeEnSureView];
}

-(void) recordCancel
{
    [voice cancelled];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"取消了" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
-(void) recordStart
{
    [voice startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()]];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 判断有摄像头，并且支持拍照功能
    // 初始化图片选择控制器
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
  
    if(buttonIndex == 2){
        return ;
    }else if(buttonIndex == 0){
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
        [controller setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
    }else{
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
        
    }
    
    [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
    [controller setDelegate:self];// 设置代理
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * img = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if(img){
        [self addPhoto:img];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)addPhoto:(UIImage*)img
{
    SHPhoto * photo = [[[NSBundle mainBundle]loadNibNamed:@"SHPhoto" owner:nil options:nil]objectAtIndex:0];
    photo.imgView.image = img;
    photo.frame = CGRectMake(200, 0, 50, 50);
    photo.btnDelete.tag = mListPhoto.count;
    [photo.btnDelete addTarget:self action:@selector(btnDeleteOnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPhoto addSubview:photo];
    
    [UIView animateWithDuration:0.3 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        photo.frame = CGRectMake(mListPhoto.count*55, 0, 50, 50);
        
    } completion:^(BOOL finished) {
        
    }];
    [mListPhoto addObject:img];
}

- (void)btnDeleteOnTouch:(UIButton*)button
{
    [mListPhoto removeObjectAtIndex:button.tag];
    
    [UIView animateWithDuration:0.3 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
        for (int i = 0; i < self.viewPhoto.subviews.count; i++) {
            if(i > button.tag){
                SHPhoto * b = [self.viewPhoto.subviews objectAtIndex:i];
                b.btnDelete.tag-=1;
                b.frame = CGRectMake(b.btnDelete.tag * 55, 0, 50, 50);
            }
        }
    } completion:^(BOOL finished) {
        [button.superview removeFromSuperview];
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    CGRect f = self.navigationController.view.frame;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.frame = f;
    }];
}

-(void) recordEnd
{
    [voice stopRecordWithCompletionBlock:^{
        
        if (((int)voice.recordTime) > 1) {
//            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\nrecord finish ! \npath:%@ \nduration:%f",voice.recordPath,voice.recordTime] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [alert show];
            
            [self showEnSureView];
        }else{
            [self showAlertDialog:@"录音时间太短"];
        }
        
    }];
}
- (void)showEnSureView
{
    self.viewEnsure.hidden = NO;
    self.viewEnsure.alpha = 0;
    CGRect frame = self.viewEnsure.frame;
    frame.origin.y = self.view.frame.size.height;
    self.viewEnsure.frame  = frame;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.viewEnsure.alpha = 1;
        self.viewEnsure.frame  = frame;
    }];
}
- (void)closeEnSureView
{
    self.viewEnsure.hidden = NO;
    CGRect frame = self.viewEnsure.frame;
    frame.origin.y = self.view.frame.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.viewEnsure.alpha = 0;
        self.viewEnsure.frame  = frame;
    }];
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
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishaswash"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishascheck"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishasmaintainance"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishassellinsurance"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishasurgentrescure"];

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
    if(annotation == selectLocation){
        
        SHSelectLocationAnnotationView* newAnnotation = [[[NSBundle mainBundle]loadNibNamed:@"SHSelectLocationAnnotationView" owner:nil options:nil] objectAtIndex:0];
        newAnnotation.annotation = annotation;
        //newAnnotation.centerOffset = CGPointMake(1000, -1000);
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;

        return newAnnotation;
        
    }else{
        NSDictionary * dic = ((SHShopPointAnnotation*)annotation).dic;
        SHShopPinAnnotationView* newAnnotation = [[[NSBundle mainBundle]loadNibNamed:@"SHShopPinAnnotationView" owner:nil options:nil] objectAtIndex:0];
        newAnnotation.annotation = annotation;
        [newAnnotation.btnAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        newAnnotation.labTitle.text = [dic valueForKey:@"shopname"];
        newAnnotation.labAddress.text = [dic valueForKey:@"shopaddress"];
        //newAnnotation.reuseIdentifier = AnnotationViewID;
//        NSString *AnnotationViewID = @"renameMark";
        
        //BMKPinAnnotationView *  newAnnotation =    [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        //newAnnotation.centerOffset = CGPointMake(1000, -100);
        
        // 设置颜色
        //    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = YES;
        // 设置可拖拽
        //((BMKPinAnnotationView*)newAnnotation).draggable = YES;
        return newAnnotation;

    }
    
    
   
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [mapView removeAnnotation:selectLocation];
    selectLocation.coordinate = mapView.centerCoordinate;
    [mapView addAnnotation:selectLocation];
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
- (IBAction)btnSearchLocationOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"locationsearch" delegate:self containner:nil];
    [[UIApplication sharedApplication]open:intent];
}
@end
