//
//  SHChatDetailViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHCommentsDetailViewController : SHTableViewController
{
    BOOL isAnimation;
    BOOL isScroll;
}
@property (weak, nonatomic) IBOutlet UITextField *txtBox;
@property (weak, nonatomic) IBOutlet UIButton *btnSender;
- (IBAction)btnSenderOnTouch:(id)sender;
- (void)checkBottom;
- (void)checkBottom2;
@end
