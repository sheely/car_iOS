//
//  SHView.m
//  Zambon
//
//  Created by sheely on 13-9-27.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHView.h"
#import "MMProgressHUD.h"

@implementation SHView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self loadSkin];
}

- (void)loadSkin
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)showAlertDialog:(NSString*)content
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate: self cancelButtonTitle:(NSString *) @"确认"  otherButtonTitles: nil];
    alert.delegate = self;
    [alert show];
}


- (void)showAlertDialogForCancel:(NSString*)content
{
    [self showAlertDialog:content button:@"确定" otherButton:@"取消"];
}

- (void)showAlertDialog:(NSString*)content otherButton:(NSString*)button
{
    [self showAlertDialog:content button:@"确定" otherButton:button];
}

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton
{
    [self showAlertDialog:content button:button otherButton:otherbutton tag:0];
}
- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton tag:(int)tag
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:self cancelButtonTitle: otherbutton otherButtonTitles :button, nil];
    alert.delegate = self;
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self alertViewCancelOnClick];
    }else if (buttonIndex == 1){
        [self alertViewEnSureOnClick];
    }
}

- (void)alertViewCancelOnClick
{
}

- (void)alertViewEnSureOnClick
{
    
}

-(void)showWaitDialog:(NSString*)title state:(NSString*)state
{
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    [MMProgressHUD showWithTitle:title status:state];
}
-(void)showWaitDialogForNetWork
{
    
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStylePlain];
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    [MMProgressHUD showWithTitle:@"请求数据..." status:@"请稍候..."];
}
-(void)showWaitDialogForNetWorkDismissBySelf
{
    [self showWaitDialogForNetWork];
    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissWaitDialog];
    });
    
}
-(void)dismissWaitDialog:(NSString*)msg
{
    [MMProgressHUD dismissWithSuccess:msg];
    
}

-(void)dismissWaitDialog
{
    [MMProgressHUD dismiss];
    
}

-(void)dismissWaitDialogSuccess
{
    [MMProgressHUD dismissWithSuccess:@"完成"];
    
}
@end
