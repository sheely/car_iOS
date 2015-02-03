//
//  SHRequirementViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/21/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHRequirementViewController.h"
#import "SHRequestView.h"
#import "LCVoice.h"
@interface SHRequirementViewController ()
{
    LCVoice * voice ;
    BMKGeoCodeSearch * _searcher;
    NSMutableArray * mListPhoto;
}
@end

@implementation SHRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((UIScrollView*)self.view).contentSize = CGSizeMake(320, 500);
    voice= [[LCVoice alloc] init];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"maintainanceinit.action");
    [post start:^(SHTask *t) {
       mList = [t.result valueForKey:@"servicecategorys"]  ;
       // mList = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
        [pickerView reloadAllComponents];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        
    }];
    self.tapGesture = YES;
    
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = SHLocationManager.instance.userlocation.location.coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    [self showWaitDialog:@"正在请求地址信息..." state:@"请稍后..."];
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    //[reverseGeoCodeSearchOption release];
    if(flag){
      NSLog(@"反geo检索发送成功");
    }
    else{
      NSLog(@"反geo检索发送失败");
    }
    mListPhoto = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}
//- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    if (error == BMK_SEARCH_NO_ERROR) {
//        //在此处理正常结果
//    }
//    else {
//        NSLog(@"抱歉，未找到结果");
//    }
//}

- (void)viewDidDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    [self dismissWaitDialog];
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        labTitle.text = result.address;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self closePickView];
}
- (void)loadSkin
{
    [super loadSkin];
    btnSubmit.layer.masksToBounds = YES;
    btnSubmit.layer.cornerRadius = 5;
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    CGRect r = self.navigationController.view.frame  ;
//    r.size.height = [UIScreen mainScreen].bounds.size.height - 49;
//    self.navigationController.view.frame = r;
//
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    CGRect r = self.navigationController.view.frame  ;
//    r.size.height = [UIScreen mainScreen].bounds.size.height;
//    self.navigationController.view.frame = r;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 判断有摄像头，并且支持拍照功能
    // 初始化图片选择控制器
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    if(mListPhoto.count > 2){
        [self showAlertDialog:@"最多上传3张图片."];
        return;
    }
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
    [viewPhote addSubview:photo];
   
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
        for (int i = 0; i < viewPhote.subviews.count; i++) {
            if(i > button.tag){
                SHPhoto * b = [viewPhote.subviews objectAtIndex:i];
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
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            self.navigationController.view.frame = f;
        }];
    }];
   
}

- (IBAction)btnCategoryOnTouch:(id)sender
{
    [self showPickView];
}

- (IBAction)btnPhotoOnTouch:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}

- (IBAction)btnRecordUpInside:(id)sender {
    [self recordEnd];
}

- (IBAction)btnTouchOutSide:(id)sender {
    [self recordCancel];
}

- (IBAction)btnToucDown:(id)sender {
    [self recordStart];
}


-(void) recordStart
{
    [voice startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/MySound.caf", NSHomeDirectory()]];
}

-(void) recordEnd
{
    [voice stopRecordWithCompletionBlock:^{
        
        if (voice.recordTime > 0.0f) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\nrecord finish ! \npath:%@ \nduration:%f",voice.recordPath,voice.recordTime] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
}

-(void) recordCancel
{
    [voice cancelled];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"取消了" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)showPickView
{
    pickerView.hidden = NO;
    pickerView.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, [UIApplication sharedApplication].keyWindow.frame.size.width, 162);
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
    [UIView animateWithDuration: 0.5 animations:^{
        pickerView.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - 162, [UIApplication sharedApplication].keyWindow.frame.size.width, 162);
        [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
        
    } completion:^(BOOL finished) {
        
    }];

}

- (void)clicktheblank
{
    [self closePickView];
}
- (void)closePickView
{
    [UIView animateWithDuration:0.5 animations:^{
        pickerView.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, [UIApplication sharedApplication].keyWindow.frame.size.width, 162);
        [[UIApplication sharedApplication].keyWindow addSubview:pickerView];

    } completion:^(BOOL finished) {
        pickerView.hidden = YES;
    }];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return mList.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSDictionary * dic =[mList objectAtIndex:row];
    SHRequestView * m = [[[NSBundle mainBundle]loadNibNamed:@"SHRequestView" owner:nil options:nil] objectAtIndex:0];
    m.labTitle.text = [dic valueForKey:@"servicecategoryname"];
    [m.imgView setUrl:[dic valueForKey:@"servicecategorylogo"]];
     return m;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSDictionary * dic =[mList objectAtIndex:row];
    [btnCategory setTitle:[dic valueForKey:@"servicecategoryname"] forState:UIControlStateNormal];

}

@end
