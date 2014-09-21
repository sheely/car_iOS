//
//  SHTableViewEditGeneralCell.h
//  Zambon
//
//  Created by yebaohua on 13-12-7.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHTableViewEditGeneralCell : SHTableViewCell
//@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
{
    __weak IBOutlet UIView *mPlan;
    
}
@property (weak, nonatomic) IBOutlet UITextView *txtTitle;

@end
