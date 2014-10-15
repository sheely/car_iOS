//
//  SHCarItemCollectionViewCell.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCarItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgState;

@property (weak, nonatomic) IBOutlet UIButton *btnItem;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@end
