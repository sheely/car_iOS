//
//  SHViewController.h
//  Core
//
//  Created by zywang on 13-9-3.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSkin.h"
#import "SHIntent.h"

@interface SHViewController : UIViewController<ISHSkin>
{
    
    
}

/**
 left right sider
 **/

@property (nonatomic,strong) SHViewController * leftViewController;
@property (nonatomic,strong) SHViewController * rightViewController;


@property (nonatomic,strong) UIView * keybordView;

@property (nonatomic,assign) int keybordheight;

@property (nonatomic,assign) id delegate;

@property (nonatomic,strong) SHIntent * intent;

- (BOOL)checkIntent:(NSString*)error;
/**
 展示等待框
 */
- (void)showWaitDialog:(NSString*)title state:(NSString*)state;

- (void)showWaitDialogForNetWork;

- (void)showWaitDialogForNetWorkDismissBySelf;
/**
 取消等待框
 */
- (void)dismissWaitDialog;

- (void)dismissWaitDialog:(NSString*)msg;

- (void)dismissWaitDialogSuccess;

- (void)dismissWaitDialogSuccess:(NSString*) title;

- (void)alertViewCancelOnClick;

- (void)alertViewEnSureOnClick;
/**
 展示对话框
 */
- (void)showAlertDialog:(NSString*)content;

- (void)showAlertDialogForCancel:(NSString*)content;

- (void)showAlertDialog:(NSString*)content otherButton:(NSString*)button;

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton;

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton tag:(int)tag;

- (void)dismiss;

- (void)btnBack:(NSObject*)sender;
/**
 侧滑
 **/
- (void)leftItemClick4ViewController;

- (void)rightItemClick4ViewController;

- (void)closeSideBar;

- (float)leftSContentOffset;

@end
