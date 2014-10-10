//
//  SHPrivinceViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"


@protocol SHProvinceViewControllerDelegate <NSObject>

- (void)provinceSubmit:(NSDictionary *)d;

@end
@interface SHProvinceViewController : SHTableViewController

@end
