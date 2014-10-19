//
//  SHOrderListViewController.h
//  Car
//
//  Created by sheely.paean.Nightshade on 10/16/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHOrderListViewController : SHViewController<UITableViewDataSource,UITableViewDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
