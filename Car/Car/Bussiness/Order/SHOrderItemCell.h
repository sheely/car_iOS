//
//  SHOrderItemCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/19/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHOrderItemCell : SHTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labShopName;
@property (weak, nonatomic) IBOutlet SHImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labOrPrice;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (strong,nonatomic) NSIndexPath * index;
@end
