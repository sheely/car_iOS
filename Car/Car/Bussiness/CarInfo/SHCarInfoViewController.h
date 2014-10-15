//
//  SHCarInfoViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHCarInfoViewController : SHTableViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UIView *viewDashBoard;
@property (weak, nonatomic) IBOutlet UIImageView *imgIndicator;
@property (weak, nonatomic) IBOutlet UILabel *labScore;

@end
