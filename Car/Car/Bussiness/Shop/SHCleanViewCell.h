//
//  SHCleanViewCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHCleanViewCell : SHTableViewCell
@property (strong,nonatomic) NSDictionary * dicInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@end
