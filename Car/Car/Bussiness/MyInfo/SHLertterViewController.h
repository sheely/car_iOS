//
//  SHLertterViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"
@protocol SHLertterViewControllerDelegate <NSObject>

- (void)letterSubmit:(NSDictionary *)d;

@end
@interface SHLertterViewController : SHTableViewController

@end
