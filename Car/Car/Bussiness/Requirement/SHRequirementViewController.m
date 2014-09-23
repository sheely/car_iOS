//
//  SHRequirementViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/21/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHRequirementViewController.h"

@interface SHRequirementViewController ()

@end

@implementation SHRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((UIScrollView*)self.view).contentSize = CGSizeMake(320, 500);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if(buttonIndex == 0){
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
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    CGRect f = self.navigationController.view.frame;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.frame = f;
    }];
}

- (IBAction)btnPhotoOnTouch:(id)sender {
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
}
@end
