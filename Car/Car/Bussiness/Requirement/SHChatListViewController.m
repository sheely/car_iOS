//
//  SHChatViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatListViewController.h"
#import "SHChatListHelper.h"
#import "SHChatListViewCell.h"

@interface SHChatListViewController ()

@end

@implementation SHChatListViewController

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
    self.title = @"受理中心";
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[SHSkin.instance image:@"navi_search_nest"] target:self action:@selector(btnSearch:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NOTIFICATION_CHATITEMLIST_CHANGED object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadNext
{
    [self showWaitDialogForNetWork];
    SHPostTaskM * task = [[SHPostTaskM alloc]init];
    task.URL= URL_FOR(@"acceptquestionlist.action");
    [task.postArgs setValue:[NSNumber numberWithInt:1] forKey:@"pageno"];
    [task.postArgs setValue:[NSNumber numberWithInt:20] forKey:@"pagesize"];
    [task start:^(SHTask *t) {
        [self dismissWaitDialog];

    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
    }];
}

- (void)notification:(NSNotification*)n
{
    mList = [[[SHChatListHelper instance]list] mutableCopy];
    [self.tableView reloadData];
}
- (void)btnSearch:(UIButton*)sender
{
    SHIntent * indent = [[SHIntent alloc]init:@"usersearchcondition" delegate:self containner:self.navigationController];
    [[UIApplication sharedApplication]open:indent];
}
- (CGFloat) tableView:(UITableView *)tableView heightForGeneralRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  68;
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatItem * item = [mList objectAtIndex:indexPath.row];
    SHChatListViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatListViewCell" owner:nil options:nil] objectAtIndex:0];
    cell.labTitle.text = item.username;
    cell.labContent.text = item.date;
    [cell.imgTitle setUrl:item.headicon];
    cell.labBottom.text = item.content;
    cell.imgNew.hidden = !item.isNew;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatdetail" delegate:nil containner:self.navigationController];
    SHChatItem * item = [mList objectAtIndex:indexPath.row];
    [[SHChatListHelper instance]cleanNewFlag:item.userid];
    [intent.args setValue:item.userid forKey:@"friendId"];
    [intent.args setValue:item.username forKey:@"friendName"];
    [intent.args setValue:item.headicon forKey:@"friendHeadicon"];

    [[UIApplication sharedApplication]open:intent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
