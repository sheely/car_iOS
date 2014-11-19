//
//  SHRepairPortCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 11/18/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHRepairPortCell : SHTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labItem;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UILabel *labBrand;
@end
