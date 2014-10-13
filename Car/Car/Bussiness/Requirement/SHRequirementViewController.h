//
//  SHRequirementViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/21/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "SHPhoto.h"
@interface SHRequirementViewController : SHViewController<UIActionSheetDelegate,UIPickerViewDataSource>
{
    NSArray * mList;
    __weak IBOutlet UIButton *btnSubmit;
    __weak IBOutlet UIPickerView *pickerView;
    __weak IBOutlet UIButton *btnCategory;
    __weak IBOutlet UILabel *labTitle;
    __weak IBOutlet UIView *viewPhote;
}
- (IBAction)btnCategoryOnTouch:(id)sender;
- (IBAction)btnPhotoOnTouch:(id)sender;
- (IBAction)btnRecordUpInside:(id)sender;
- (IBAction)btnTouchOutSide:(id)sender;
- (IBAction)btnToucDown:(id)sender;
@end
