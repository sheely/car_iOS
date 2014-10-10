//
//  SHShopInfoViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 9/25/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@interface SHShopInfoViewController : SHTableViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
- (IBAction)btnContact:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labScore;

@end
