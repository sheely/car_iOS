//
//  SHShopListCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/24/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHShopListCell : SHTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labNewPrice;
@property (weak, nonatomic) IBOutlet SHImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *labShopName;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labScore;
@end
