//
//  SHMyInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/26/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHMyInfoViewController.h"
#import "SHQuitCell.h"
#import "SHMyBaseInfoCell.h"

@interface SHMyInfoViewController ()<UITextFieldDelegate>
{
    NSDictionary * dic ;
}
@end

@implementation SHMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    [self request];
    // Do any additional setup after loading the view from its nib.
}

- (void)request
{
    [self showWaitDialogForNetWork];
    SHPostTaskM *post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"meinfoquery.action");
    [post start:^(SHTask *t) {
        dic = t.result;
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 ||( indexPath.section == 2 && indexPath.row == 4)) {
        return 80;
    }
    return 44;
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 2;
        
    }else if (section == 2){
        return 5;
    }
    return 0;
}

- (void)btnImage:(UIButton*)b
{
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    CGRect f = self.navigationController.view.frame;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        self.navigationController.view.frame = f;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self showWaitDialogForNetWork];
    UIImage * img = [info valueForKey:@"UIImagePickerControllerEditedImage"];
    if(img){
        //[self addPhoto:img];
        SHPostTaskM *post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"meinfomodify.action");
        [post.postArgs setValue:[SHBase64 encode:UIImagePNGRepresentation(img) ] forKey:@"myheadicon"];
        [post.postArgs setValue: [dic valueForKey:@"mynickname"] forKey:@"mynickname"];

        [post start:^(SHTask *t) {
            [self request];
            [self dismissWaitDialog];
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
            [self dismissWaitDialog];
        }];

    }
    CGRect f = self.navigationController.view.frame;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.view.frame = f;
            
        }];
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField             // called when 'return' key pressed. return NO to ignore.
{
    [self showWaitDialogForNetWork];
    if(textField.text.length > 0){
        SHPostTaskM *post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"meinfomodify.action");
        [post.postArgs setValue:@""  forKey:@"myheadicon"];
        [post.postArgs setValue: textField.text forKey:@"mynickname"];
        [post start:^(SHTask *t) {
            [self request];
            [self dismissWaitDialog];
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
            [t.respinfo show];
            [self dismissWaitDialog];
        }];

    }else{
        textField.text = [dic valueForKey:@"mynickname"];
    }
    [textField resignFirstResponder];
    return YES;
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
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        SHMyBaseInfoCell* cell = [[[NSBundle mainBundle]loadNibNamed:@"SHMyBaseInfoCell" owner:nil options:nil]objectAtIndex:0];
        cell.backgroundColor = [UIColor whiteColor];
        cell.labPhone.text = [NSString stringWithFormat:@"手机号码:%@", [[dic valueForKey:@"myusername"] length] == 0 ? @"":[dic valueForKey:@"myusername"]];
        cell.txtFieldName.text = [dic valueForKey:@"mynickname"];
        cell.txtFieldName.delegate = self;
        [cell.imgHead setUrl:[dic valueForKey:@"myheadicon"]];
        [cell.btnImage addTarget:self action:@selector(btnImage:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
           SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"我的车辆";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else {
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"我的优惠卷";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }
    }
    else if (indexPath.section == 2){
        if(indexPath.row == 0){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"五星好评";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 1){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"检查更新";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 2){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.labTitle.text = @"关于我们";
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if (indexPath.row == 3){
            SHTableViewGeneralCell * cell =  [tableView dequeueReusableGeneralCell];
            cell.backgroundColor = [UIColor whiteColor];
            cell.labTitle.text = @"拨打客服电话";
            return cell;
        }else if (indexPath.row == 4){
            SHQuitCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHQuitCell" owner:nil options:nil]objectAtIndex:0];
            cell.backgroundColor = [UIColor whiteColor];
            [cell.btnQuit addTarget:self action:@selector(btnQuit:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    }
    
    return nil;
}

- (void)btnQuit:(NSObject*)b
{
    SHEntironment.instance.password = @"";
    [self performSelector:@selector(reLogin) afterNotification:@"notification_login_successful"];
}

- (void)reLogin
{
    [self request];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            SHIntent * intent = [[SHIntent alloc]init:@"mycarlist" delegate:self containner:self.navigationController];
            [[UIApplication sharedApplication]open:intent];

        }else{
            SHIntent * intent = [[SHIntent alloc]init:@"goupon" delegate:self containner:self.navigationController];
            [[UIApplication sharedApplication]open:intent];
        }
    }else if (indexPath.section == 2){
        if(indexPath.row == 2){
            SHIntent * intent = [[SHIntent alloc]init:@"titlecontent" delegate:self containner:self.navigationController];
            [intent.args setValue:@"关于我们" forKey:@"title"];
            [intent.args setValue:[dic valueForKey:@"aboutus"] forKey:@"content"];
            [[UIApplication sharedApplication]open:intent];
        }else if(indexPath.row == 3){
            NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",[dic valueForKey:@"clienthotline"]];
            NSURL *url = [[NSURL alloc] initWithString:telUrl];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
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
