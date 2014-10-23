//
//  SHLocationViewController.h
//  Car
//
//  Created by WSheely on 14/10/23.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"

@class SHLocationViewController;

@protocol SHLocationViewControllerDelgate <NSObject>

- (void)locationcontroller:(SHLocationViewController*) controller onSubmit:(BMKPoiInfo*)poi;

@end

@interface SHLocationViewController : SHViewController<BMKPoiSearchDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
