//
//  SHShowTableViewController.h
//  Zambon
//
//  Created by sheely on 13-9-8.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHTableViewController.h"

@interface SHShowTableViewController : SHTableViewController

{
     UILabel * mLabel;
}
@property  (nonatomic,strong)IBOutlet UILabel * labTitle;
@property (nonatomic,strong) NSString * title;
@end
