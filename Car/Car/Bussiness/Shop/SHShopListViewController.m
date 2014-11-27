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
#import "lame.h"
#import "SHCategoryView.h"

@interface SHShopListViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>
{
    LCVoice * voice ;
    NSMutableArray * mListPhoto;
    BMKGeoCodeSearch * _searcher;
    SHShopPointAnnotation* selectLocation;
    NSMutableArray * mListAnimation;
    NSArray *mCategroy;
    int type;
    NSDictionary * mDicCategorySelected;
    NSString *cafFilePath;
    NSString *mp3FilePath;
    SHCalendarViewController * calendarcontroller;
    CGRect orgFrame ;
    NSDictionary * checkticket;
    NSString * appointmentDate;
    NSString * washticketid;
    float finalprice;
    NSString * checkorderid;
    BOOL isFirst;
}
@end

@implementation SHShopListViewController
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
    type = -1;
    isFirst = YES;
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
        
        SHPostTaskM * p  = [[SHPostTaskM alloc]init];
        p.URL= URL_FOR(@"mywashticketsquery.action");
        [p.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"tickettype"];
        [p.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"isonlyexpired"];
        [p start:^(SHTask *t) {
            NSArray * array = [t.result valueForKey:@"mywashtickets"];
            if(array.count > 0 ){
                checkticket = [array objectAtIndex:0];
            }
        }
     taskWillTry:nil
   taskDidFailed:^(SHTask *t) {
       [self dismissWaitDialog];
   }];
    }else if ([[self.intent.args valueForKey:@"type"] isEqualToString:@"consultation"]){
        self.tableView.hidden = YES;
        self.viewCheck.hidden = YES;
        self.imgBgView.hidden = NO;
        self.viewRequest.hidden = NO;
        type = 2;

    }else {
        if([[self.intent.args valueForKey:@"type"]isEqualToString:@"repair"]){
            type = 1;
        }else if([[self.intent.args valueForKey:@"type"]isEqualToString:@"support"]){
            type = 0;

        }
        else if([[self.intent.args valueForKey:@"type"]isEqualToString:@"insurance"]){
            type = 4;
        }
        
        self.tableView.hidden = YES;
        self.viewCheck.hidden = YES;
        self.viewRequest.hidden = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [UIImage imageNamed:@"icon_list"] target:self action:@selector(checkListMap)];

    }
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"maintainanceinit.action");
    if(type > -1){
        [post.postArgs setValue:[NSNumber numberWithInt:type] forKey:@"requesttype"];
        [post start:^(SHTask *t) {
            int count = 3;
            
            if([[self.intent.args valueForKey:@"type"]isEqualToString:@"support"]){
                count = 2;
            }
            int width = (self.view.frame.size.width - 20);
            int perwidth = width/count;
            mCategroy = [t.result valueForKey:@"servicecategorys"];
            int ys = mCategroy.count/count +( mCategroy.count%count > 0 ?1:0);
            for (int i = 0; i< mCategroy.count; i++) {
                NSDictionary  * dic = [mCategroy objectAtIndex:i];
                int y = i/count;
                SHCategoryView * view = [[[NSBundle mainBundle]loadNibNamed:@"SHCategoryView" owner:nil options:nil] objectAtIndex:0];
                view.frame = CGRectMake(10+i*perwidth - y* width, 40*y, perwidth+0.5, 40.5);
                [view.btnTitle setTitle:[dic valueForKey:@"servicecategoryname"] forState:UIControlStateNormal];
                view.btnTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
                [view.btnTitle addTarget:self action:@selector(btnCategoryOnTouch:) forControlEvents:UIControlEventTouchUpInside];
                view.btnTitle.tag = i;
                
                [self.viewCategory insertSubview:view atIndex:0];
                view.tag = i;
                if(i == 0){
                    view.selected = YES;
                    mDicCategorySelected = dic;
                }
            }
            CGRect frame = self.viewEnsure.frame;
            frame.origin.y -= 40 * ys;
            frame.size.height += 40 * ys;
            self.viewEnsure.frame = frame;
            
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            
        }];
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
    selectLocation = [[SHShopPointAnnotation alloc]init];
    selectLocation.coordinate = _mapView.centerCoordinate;//SHLocationManager.instance.userlocation.location.coordinate;
    selectLocation.title = @"当前点";
    selectLocation.subtitle = @"此Annotation可拖拽!";
    [_mapView addAnnotation:selectLocation];
    mListAnimation = [[NSMutableArray alloc]init];
    [self refreshAdress];
    orgFrame =  self.navigationController.view.frame;
    // Do any additional setup after loading the view from its nib.
}

- (void)btnCategoryOnTouch:(UIButton*)sender
{
    for (SHCategoryView * v in self.viewCategory.subviews) {
        v.selected = NO;
    }
    ((SHCategoryView*)sender.superview).selected = YES;
    mDicCategorySelected = [mCategroy objectAtIndex:sender.tag];
}

- (void)refreshAdress
{
    CLLocationCoordinate2D pt = selectLocation.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    [_searcher reverseGeoCode:reverseGeoCodeSearchOption];

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
    self.txtField.layer.borderColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1].CGColor;
    self.txtField.layer.borderWidth = 0.5;
    self.txtField.layer.cornerRadius = 5;
    self.btnTxt.layer.borderColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1].CGColor;
    self.btnTxt.layer.borderWidth = 0.5;
    self.btnTxt.layer.cornerRadius = 5;

    self.keybordView = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [self.txtField resignFirstResponder];
    if(textField == self.txtField){
        [self showEnSureView];
    }
    return YES;
}
- (IBAction)btnRecordUpInside:(id)sender
{
    [self recordEnd];
}

- (IBAction)btnPlayOnTouch:(id)sender
{
    if(player.isPlaying){
        [self.btnPlay setImage: [UIImage imageNamed:@"icon_play_com.png" ] forState:UIControlStateNormal];
        [player stop];
    }else{
        [self.btnPlay setImage: [UIImage imageNamed:@"icon_stop_com.png" ] forState:UIControlStateNormal];
        [player play];
    }
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
    sheet.tag = 0;
    [sheet showInView:self.view];
}

- (IBAction)btnEnsureOnTouch:(id)sender
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"maintainance.action");
    [post.postArgs setValue:self.txtField.text forKey:@"problemdesc"];
    [post.postArgs setValue:self.labLocation.text forKey:@"location"];
    if(mListPhoto.count > 0){
        NSMutableArray * base64phote = [[NSMutableArray alloc]init];
        for (UIImage * img  in mListPhoto) {
            [base64phote addObject:[SHBase64 encode:UIImagePNGRepresentation(img) ]];
        }
        [post.postArgs setValue:base64phote forKey:@"uploadedpicture"];
    }else{
        [post.postArgs setValue:[[NSArray alloc]init] forKey:@"uploadedpicture"];
    }
    if(mp3FilePath.length > 0){
    [post.postArgs setValue:[SHBase64 encode:[NSData dataWithContentsOfFile:mp3FilePath]] forKey:@"sound"];
    }else{
        [post.postArgs setValue:[SHBase64 encode:[[NSData alloc] init]] forKey:@"sound"];

    }
    [post.postArgs setValue:[NSNumber numberWithFloat:selectLocation.coordinate.latitude] forKey:@"lat"];
    [post.postArgs setValue:[NSNumber numberWithFloat:selectLocation.coordinate.longitude]forKey:@"lgt"];
    [post.postArgs setValue:[mDicCategorySelected valueForKey:@"servicecategoryid"] forKey:@"servicecategoryid"];
    [post start:^(SHTask *t) {
        self.txtField.text = @"";
        [mListPhoto removeAllObjects];
        for (UIView* v in self.viewPhoto.subviews) {
            [v removeFromSuperview];
        }
        mp3FilePath = @"";
        [t.respinfo show];
        [self dismissWaitDialog];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_UPDATE_REQUIRE object:nil];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
    
    [self closeEnSureView];
}

- (IBAction)btnTxtOnTouch:(id)sender
{
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
-(void) recordEnd
{
    [voice stopRecordWithCompletionBlock:^{
        
        if (((int)voice.recordTime) > 1) {
//                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\nrecord finish ! \npath:%@ \nduration:%f",voice.recordPath,voice.recordTime] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//                        [alert show];
            [self audio_PCMtoMP3];
            [self showEnSureView];
        }else{
            [self showAlertDialog:@"录音时间太短"];
        }
        
    }];
}

- (void)audio_PCMtoMP3
{
    
    cafFilePath = voice.recordPath;
    mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];

    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil]){
        NSLog(@"删除");
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 44100.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        NSError *playerError;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:mp3FilePath] error:&playerError];
        self.player = audioPlayer;
        player.volume = 1.0f;
        if (player == nil){
            NSLog(@"ERror creating player: %@", [playerError description]);
        }
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
        player.delegate = self;
    }
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    // 判断有摄像头，并且支持拍照功能
//    // 初始化图片选择控制器
//    if(actionSheet.tag == 0){
//        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//        
//        if(buttonIndex == 2){
//            return ;
//        }else if(buttonIndex == 0){
//            [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
//            [controller setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
//        }else{
//            [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
//            
//        }
//        
//        [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
//        [controller setDelegate:self];// 设置代理
//        [self.navigationController presentViewController:controller animated:YES completion:nil];
//    }else {
//        if(buttonIndex == 0){
//            washticketid = [checkticket valueForKey:@"washticketid"];
//            [self payment];
//        }else if (buttonIndex == 1) {
//            washticketid = @"";
//            [self payment];
//        }
//    }
//}



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
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.frame = orgFrame;
        }];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * img = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if(img){
        [self addPhoto:img];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.frame = orgFrame;
        }];
    }];
}

- (void)showEnSureView
{
    self.btnPlay.titleLabel.text = [NSString stringWithFormat:@"%d\"",(int)voice.recordTime] ;
    self.viewEnsure.hidden = NO;
    self.viewEnsure.alpha = 0;
    self.btnTxt.hidden = self.txtField.hidden;
    [self.btnTxt setTitle:self.txtField.text forState:UIControlStateNormal];
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

- (void)reSet
{
    mIsEnd = NO;
    [mList removeAllObjects];
    [_mapView removeAnnotations:mListAnimation];
    [mListAnimation removeAllObjects];
}
-(void)loadNext
{
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    task.URL= URL_FOR(@"shopquery.action");
    [task.postArgs setValue:@"" forKey:@"keyname"];
    [task.postArgs setValue:[NSNumber numberWithFloat:selectLocation.coordinate.latitude]  forKey:@"lat"];
    [task.postArgs setValue:[NSNumber numberWithFloat: selectLocation.coordinate.longitude] forKey:@"lgt"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"pageno"];
    [task.postArgs setValue:[NSNumber numberWithFloat:15] forKey:@"pagesize"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishaswash"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishascheck"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishasmaintainance"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishassellinsurance"];
    [task.postArgs setValue:[NSNumber numberWithFloat:1] forKey:@"ishasurgentrescure"];

    [task start:^(SHTask *t) {
        mList = [t.result valueForKey:@"nearshops"];
        mIsEnd = YES;
//        CLLocationCoordinate2D far;
//        CLLocationDistance distance = 0;
//        BMKMapPoint point1 = BMKMapPointForCoordinate(selectLocation.coordinate);
        for (int i = 0 ;i <mList.count; i++) {
            NSDictionary * m  =  [mList objectAtIndex:i];
            SHShopPointAnnotation* pointAnnotation = [[SHShopPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [[[m valueForKey:@"baidulatitude"] valueForKey:@"lat"] floatValue];
            coor.longitude = [[[m valueForKey:@"baidulatitude"] valueForKey:@"lgt"] floatValue];
            pointAnnotation.coordinate = coor;
            pointAnnotation.title = @"test";
            pointAnnotation.subtitle = @"此Annotation可拖拽!";
            pointAnnotation.tag = i;
//            BMKMapPoint point2 = BMKMapPointForCoordinate(coor);
//            CLLocationDistance distance_ = BMKMetersBetweenMapPoints(point1,point2);
//            if(distance_ > distance){
//                distance = distance_;
//                far = coor;
//            }
//            
            
            [_mapView addAnnotation:pointAnnotation];
            [mListAnimation addObject:pointAnnotation];
        }
//        BMKCoordinateRegion region;
//        if(mList.count > 1){
//            region.center =selectLocation.coordinate;
//            region.span = BMKCoordinateSpanMake((far.latitude - selectLocation.coordinate.latitude)*1.5, (far.longitude - selectLocation.coordinate.longitude)*1.5);
//           // [_mapView setRegion:region animated:YES];
//        }
        if(isFirst){
            isFirst = NO;
            [_mapView setZoomLevel:12];
        
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
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = NO;

        return newAnnotation;
        
    }else{
        NSDictionary * dic = [mList objectAtIndex:((SHShopPointAnnotation*)annotation).tag];
        SHShopPinAnnotationView* newAnnotation = [[[NSBundle mainBundle]loadNibNamed:@"SHShopPinAnnotationView" owner:nil options:nil] objectAtIndex:0];
        newAnnotation.annotation = annotation;
        [newAnnotation.btnAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        newAnnotation.btnAction.tag =((SHShopPointAnnotation*)annotation).tag;
        newAnnotation.labTitle.text = [dic valueForKey:@"shopname"];
        newAnnotation.labAddress.text = [dic valueForKey:@"shopaddress"];
        [newAnnotation.imgView setUrl:[dic valueForKey:@"shoplogo"]];
        
        int score = [[dic valueForKey:@"shopscore"] integerValue];
        switch (score) {
                
            case 5:
                newAnnotation.img5.image = [SHSkin.instance image:@"star_selected.png"];
            case 4:
                newAnnotation.img4.image = [SHSkin.instance image:@"star_selected.png"];
            case 3:
                newAnnotation.img3.image = [SHSkin.instance image:@"star_selected.png"];
            case 2:
                newAnnotation.img2.image = [SHSkin.instance image:@"star_selected.png"];
            case 1:
                newAnnotation.img1.image = [SHSkin.instance image:@"star_selected.png"];
                break;
                
            default:
                break;
        }
        //newAnnotation.reuseIdentifier = AnnotationViewID;
//        NSString *AnnotationViewID = @"renameMark";
        //BMKPinAnnotationView *  newAnnotation =    [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        //newAnnotation.centerOffset = CGPointMake(1000, -100);
        
        // 设置颜色
        //    ((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        ((BMKPinAnnotationView*)newAnnotation).animatesDrop = NO;
        // 设置可拖拽
        //((BMKPinAnnotationView*)newAnnotation).draggable = YES;
        return newAnnotation;

    }
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(selectLocation.coordinate);
    BMKMapPoint point2 = BMKMapPointForCoordinate(mapView.centerCoordinate);
    
    CLLocationDistance distance_ = BMKMetersBetweenMapPoints(point1,point2);

    if(distance_ > 10){
        [self reSet];
        [self.tableView reloadData];
        [_mapView removeAnnotation:selectLocation];
        selectLocation.coordinate = _mapView.centerCoordinate;
        [_mapView addAnnotation:selectLocation];
        [self refreshAdress];
        
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    SHShopListCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHShopListCell" owner:nil options:nil] objectAtIndex:0];
    [cell.imgHead setUrl:[dic valueForKey:@"shoplogo"]];
    cell.labShopName.text = [dic valueForKey:@"shopname"];
    cell.labAddress.text = [dic valueForKey:@"shopaddress"];
    cell.labDistance.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"distancefromme"]];
    cell.labScore.text = [NSString stringWithFormat:@"%@分", [dic valueForKey:@"shopscore"]];
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
    NSDictionary * dic = [mList objectAtIndex:sender.tag];
    SHIntent * i =  [[SHIntent alloc]init:@"shopinfo" delegate:nil containner:self.navigationController];
    [i.args setValue:[dic valueForKey:@"shopid"] forKey:@"shopid"];
    [[UIApplication sharedApplication]open:i];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnAppointmentOnTouch:(id)sender

{
    
    calendarcontroller  = [[SHCalendarViewController alloc]init];
    calendarcontroller.delegate = self;
    [calendarcontroller show];
}


- (IBAction)btnCheckOnTouch:(id)sender {
    appointmentDate = @"";
    [self pay];
}

-(void)calendarViewController:(SHCalendarViewController *)controller dateEnsure:(NSDate *)date
{
    [calendarcontroller close];
    appointmentDate = [date descriptionWithLocale: [ [ NSLocale alloc ] initWithLocaleIdentifier : @"zh_CN" ]];
    [self pay];
}
- (void)pay
{
    self.viewCheckOrder.frame = self.view.bounds;
    self.viewCheckOrder.checkticket = checkticket;
    self.viewCheckOrder.delegate = self;
    [self.view addSubview:self.viewCheckOrder];
}

-(void)checkorderviewOnSubmit:(SHCheckOrderView*)view
{
    if(view.btnCoupon.selected){
        washticketid = [checkticket valueForKey:@"washticketid"];
    }else{
        washticketid = @"";
    }
    [self payment];
}
- (void)payment
{
    
    [self showWaitDialog:@"正在下单" state:@"请稍后..."];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"checkordercreate.action");
    
    [post.postArgs  setValue:[NSNumber numberWithInt:0] forKey:@"checkordertype"];
    [post.postArgs  setValue:washticketid == nil ? @"":washticketid forKey:@"ticketid"];
    [post.postArgs  setValue:appointmentDate == nil ? @"" : appointmentDate forKey:@"reserverdatetime"];
    
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
        checkorderid = [t.result valueForKey:@"orderid"] ;
        finalprice = [[t.result valueForKey:@"finalprice"] floatValue];
        if(finalprice ==0 ){
            [t.respinfo show];
        }else {
            UIAlertView * a = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"确认支付［%g]元.",finalprice ] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
            a.tag = 1;
            [a show];

        }
        
    } taskWillTry:nil
  taskDidFailed:^(SHTask *t) {
      [t.respinfo show];
      [self dismissWaitDialog];
  }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
            NSString *appScheme = @"car";
            //[[t.result valueForKey:@"finalprice"] floatValue]
            AlixPayOrder *order = [[AlixPayOrder alloc] init];
            order.partner = PartnerID;
            order.seller = SellerID;
            order.tradeNO =checkorderid; //订单ID（由商家自行制定）
            order.productName = [NSString stringWithFormat:@"%@-%@",@"车辆检测",@"服务费"]; ; //商品标题
            order.productDescription = [NSString stringWithFormat:@"%@-%@",@"车辆检测",@"服务费"]; //商品描述
            order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格//discountafteronlinepay
            order.notifyURL =  URL_FOR( @"notify_url.jsp"); //回调URL
            
            NSString* orderInfo = [order description];
            NSString* signedStr = [self doRsa:orderInfo];
            NSLog(@"%@",signedStr);
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                     orderInfo, signedStr, @"RSA"];
            [AlixLibService payOrder:orderString AndScheme:appScheme seletor: @selector(paymentResult:)
                              target:self];
        }
    }
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    if (result){
        if (result.statusCode == 9000){
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            if ([verifier verifyString:result.resultString withSign:result.signString]){
                //验证签名成功，交易结果无篡改
                [self showAlertDialog:@"支付成功."];
            }
        }
        else{
            //交易失败
            [self showAlertDialog:@"交易失败."];
        }
    }
    else{
        //失败
        [self showAlertDialog:@"交易失败."];
        
    }
    
}




- (IBAction)btnKeybord:(UIButton*)sender {
    if(self.txtField.hidden ){
        self.keybordView = self.viewRequest;
        self.keybordheight = 200;
        self.txtField.hidden = NO;
        self.txtField.alpha = 0;
        [self.txtField becomeFirstResponder];
        [UIView animateWithDuration:0.5 animations:^{
            [sender setImage:[UIImage imageNamed:@"btn_mic.png"] forState:UIControlStateNormal];

              self.txtField.alpha = 1;
        } completion:nil];
    }else{
      
        [self.txtField resignFirstResponder];

        [UIView animateWithDuration:0.5 animations:^{
            self.txtField.alpha = 0;
            [sender setImage:[UIImage imageNamed:@"btn_keyboard.png"] forState:UIControlStateNormal];
        } completion:^(BOOL finished){self.txtField.hidden = YES;finished = YES;  self.keybordView = nil;}];

    }
    
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.btnPlay setImage: [UIImage imageNamed:@"icon_play_com.png" ] forState:UIControlStateNormal];
}

- (IBAction)btnSearchLocationOnTouch:(id)sender
{
    SHIntent * intent = [[SHIntent alloc]init:@"locationsearch" delegate:self containner:nil];
    [[UIApplication sharedApplication]open:intent];
}

- (void)locationcontroller:(SHViewController*) controller onSubmit:(BMKPoiInfo*)poi
{
    [SHIntentManager clear];
    [self.mapView setCenterCoordinate:poi.pt animated:YES];
}


@end
