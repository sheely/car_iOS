//
//  SHTableViewSelectCell.h
//  offer_neptune
//
//  Created by yebaohua on 14-6-18.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHTableViewSelectCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelect;
@property (weak, nonatomic) IBOutlet UIImageView *imgLine;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@end
