//
//  SHSelectionViewController.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHTableViewController.h"

@class SHSelectionViewController;

@protocol SHSelectionViewControllerDelegate <NSObject>

- (void)selectionViewController:(SHSelectionViewController*)controller selectIndex:(int)index;

@end

@interface SHSelectionViewController : SHTableViewController
{
    
}
@property (nonatomic,strong) NSArray* list;
@property (nonatomic,strong) NSObject * selectObj;
@property (nonatomic,weak) id<SHSelectionViewControllerDelegate> delegate;
@end
