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
    mIsEnd = YES;
      mList = [[[SHChatListHelper instance]list] mutableCopy];
    [self.tableView reloadData];
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
    cell.labTitle.text = item.problemdesc;
    if(item.asktime.length > 0){
        NSDate * date = [self dateFromString:item.asktime];
        if([[date addDay:1] earlierDate:[NSDate date]]){
            cell.labContent.text = [item.asktime substringWithRange:NSMakeRange(11,5)];
        }else{
            cell.labContent.text = [item.asktime substringWithRange:NSMakeRange(0,10)];
        }
    }
    
    [cell.imgTitle setUrl:item.uploadpicture];
    cell.labBottom.text = item.latestmessage;
    cell.imgNew.hidden = !item.isNew;
    return cell;
}
- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHIntent * intent = [[SHIntent alloc]init:@"chatdetail" delegate:nil containner:self.nav];
    SHChatItem * item = [mList objectAtIndex:indexPath.row];
    [intent.args setValue:item.questionid forKey:@"questionid"];
    //    [[SHChatListHelper instance]cleanNewFlag:item.userid];
    //    [intent.args setValue:item.userid forKey:@"friendId"];
    //    [intent.args setValue:item.username forKey:@"friendName"];
    //    [intent.args setValue:item.headicon forKey:@"friendHeadicon"];
    
    [[UIApplication sharedApplication]open:intent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
