//
//  SHSelectionViewController.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by sheely on 13-9-10.
//  Copyright (c) 2013年 MobilityChina. All rights reserved.
//

#import "SHSelectionViewController.h"
#import "SHTableViewTitleImageCell.h"
@interface SHSelectionViewController ()

@end

@implementation SHSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHTableViewTitleImageCell * cell = (SHTableViewTitleImageCell*)[super dequeueReusableTitleImageCell];
    NSObject * obj = [self.list objectAtIndex:indexPath.row];
    if([obj isKindOfClass:[NSString class]] == YES){
        cell.labTitle.text = (NSString  *)obj;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectionViewController:selectIndex:)]){
        [self.delegate selectionViewController:self selectIndex:indexPath.row];
    }
}

@end
