//
//  SHCarInfoListCell.h
//  Car
//
//  Created by WSheely on 14-10-7.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHCarInfoListCell : SHTableViewTitleContentCell
@property (weak, nonatomic) IBOutlet SHImageView *imgView;
@property (weak, nonatomic) IBOutlet SHImageView *imgState;
@property (weak, nonatomic) IBOutlet UILabel *labBotton;

@end
