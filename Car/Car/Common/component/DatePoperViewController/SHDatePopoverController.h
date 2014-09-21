//
//  SHDatePopoverController.h
//  Zambon
//
//  Created by sheely.paean.Nightshade on 12/11/13.
//  Copyright (c) 2013 zywang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"

@protocol SHDatePopoverControllerDelegate<UIPopoverControllerDelegate,VRGCalendarViewDelegate>
@end

@interface SHDatePopoverController : UIPopoverController<VRGCalendarViewDelegate>
{
    @protected
    VRGCalendarView * mCalendar;
}

@property (nonatomic, retain) NSDate *selectedDate;

//@property (nonatomic, strong) UIColor* selectColor;

@property (nonatomic,weak) id <SHDatePopoverControllerDelegate> delegate;
@end
