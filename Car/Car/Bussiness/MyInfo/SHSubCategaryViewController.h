//
//  SHSubCategaryViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"

@protocol SHSubCategaryViewControllerDeleate <NSObject>

- (void)subCategarySubmit:(NSDictionary *)d;

@end

@interface SHSubCategaryViewController : SHTableViewController

@end
