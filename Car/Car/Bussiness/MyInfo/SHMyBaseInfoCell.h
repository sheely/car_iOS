//
//  SHMyBaseInfoCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/26/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHMyBaseInfoCell : SHTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *txtFieldName;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (weak, nonatomic) IBOutlet SHImageView *imgHead;
@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@end
