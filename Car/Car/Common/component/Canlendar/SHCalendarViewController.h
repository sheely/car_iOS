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
@end

@interface SHCalendarViewController : SHViewController
{
    __weak IBOutlet VRGCalendarView *canlendarView;
    
}

@property (weak,nonatomic) id <SHCalendarViewControllerDelegate> delegate;
- (void)show;
- (void)close;
- (IBAction)btnOnTouch:(id)sender;

@end
