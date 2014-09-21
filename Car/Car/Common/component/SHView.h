//
//  SHView.h
//  Zambon
//
//  Created by sheely on 13-9-27.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHView : UIView<ISHSkin>
- (void)showWaitDialog:(NSString*)title state:(NSString*)state;

- (void)dismissWaitDialog;

- (void)dismissWaitDialog:(NSString*)msg;

- (void)dismissWaitDialogSuccess;

- (void)showWaitDialogForNetWork;

- (void)showWaitDialogForNetWorkDismissBySelf;

- (void)alertViewCancelOnClick;

- (void)alertViewEnSureOnClick;

- (void)showAlertDialog:(NSString*)content;

- (void)showAlertDialogForCancel:(NSString*)content;

- (void)showAlertDialog:(NSString*)content otherButton:(NSString*)button;

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton;

- (void)showAlertDialog:(NSString*)content button:(NSString*)button otherButton:(NSString*)otherbutton tag:(int)tag;
@end
