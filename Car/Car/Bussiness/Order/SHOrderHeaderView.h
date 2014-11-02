//
//  SHOrderItemViewCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/19/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHOrderHeaderView : SHView
@property (weak, nonatomic) IBOutlet SHImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labCarId;
@property (weak, nonatomic) IBOutlet UILabel *labTimer;

@end
