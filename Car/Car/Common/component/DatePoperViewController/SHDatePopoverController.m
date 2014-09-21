//
//  SHDatePopoverController.m
//  Zambon
//
//  Created by sheely.paean.Nightshade on 12/11/13.
//  Copyright (c) 2013 zywang. All rights reserved.
//

#import "SHDatePopoverController.h"

@implementation SHDatePopoverController

@synthesize delegate;


- (id)init
{
    mCalendar = [[VRGCalendarView alloc] init];
    mCalendar.delegate = self;
    UIViewController * controller = [[UIViewController alloc]init];
    controller.view = mCalendar;
    mCalendar.selectColor = [SHSkin.instance colorOfStyle:@"ColorStyleCellSelected"];
    self.popoverContentSize = mCalendar.bounds.size;
    if (self = [super initWithContentViewController:controller]){
        
    }
    return self;
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    self.popoverContentSize = mCalendar.bounds.size;
    if(self.delegate && [self.delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]){
        [self.delegate calendarView:calendarView switchedToMonth:month targetHeight:targetHeight animated:animated];
    }
}

- (NSDate*)selectedDate
{
    return mCalendar.selectedDate;
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    mCalendar.selectedDate = selectedDate;
}
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(calendarView:dateSelected:)]){
        [self.delegate calendarView:calendarView dateSelected:date];
    }
}
@end
