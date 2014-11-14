//
//  SHCalendarViewController.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-16.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHCalendarViewController;

@protocol SHCalendarViewControllerDelegate <NSObject,VRGCalendarViewDelegate>

-(void)calendarViewController:(SHCalendarViewController *)controller dateSelected:(NSDate *)date;

-(void)calendarViewController:(SHCalendarViewController *)controller dateEnsure:(NSDate *)date;
@end

@interface SHCalendarViewController : SHViewController
{
    __weak IBOutlet VRGCalendarView *canlendarView;
    
}

@property (weak,nonatomic) id <SHCalendarViewControllerDelegate> delegate;
- (void)show;
- (void)close;
- (IBAction)btnOnTouch:(id)sender;
- (IBAction)btnCancelOnTouch:(id)sender;
- (IBAction)btnEnsureOnTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnEnsure;

@end
