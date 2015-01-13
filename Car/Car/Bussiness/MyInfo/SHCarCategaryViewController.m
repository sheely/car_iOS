//
//  SHCarCategaryViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/10/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCarCategaryViewController.h"
#import "SHCarCategaryCellInfoCell.h"

@interface SHCarCategaryViewController ()
{
    NSMutableArray * mList;
}
@end

@implementation SHCarCategaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车型选择";
    [self loadNext];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[mList objectAtIndex:section] valueForKey:@"firstLetter"];
}


- (void)loadNext
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"carcategoryquery.action");
    [post start:^(SHTask *t) {
        mList = [t.result valueForKey:@"letterCarCategoryList"];
        [self.tableView reloadData];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];

    }];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray * m = [[NSMutableArray alloc]init];
    for (NSDictionary * b in mList) {
        [m addObject:[b valueForKey:@"firstLetter"]];
    }
    
    return m;
    
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[mList objectAtIndex:section] valueForKey:@"carcategorys"] count];
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
   return  [mList count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [[[mList objectAtIndex:indexPath.section] valueForKey:@"carcategorys"] objectAtIndex:indexPath.row];
    SHCarCategaryCellInfoCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCarCategaryCellInfoCell" owner:nil options:nil]objectAtIndex:0];
    cell.labTitle.text = [dic valueForKey:@"carcategoryname"];
    [cell.imgIcon setUrl:[dic valueForKey:@"carcategorylogo"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(categarySubmit:)]){
        [( id<SHCategaryViewControllerDeleate> ) self.delegate categarySubmit:[[[mList objectAtIndex:indexPath.section] valueForKey:@"carcategorys"] objectAtIndex:indexPath.row]];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
