//
//  SHChatUnitViewCell.h
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHChatUnitViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTxt;
@property (weak, nonatomic) IBOutlet SHImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *labTimer;

@end
