//
//  SHChatDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-7-27.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHChatDetailViewController.h"
#import "SHChatUnitViewCell.h"
#import "SHChatListHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface SHChatDetailViewController ()
{
}
@end

@implementation SHChatDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadNext
{
    [self showWaitDialogForNetWork];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"acceptquestiondetail.action");
    [post.postArgs setValue:@"4028478148f8feca0148f91292030002" forKey:@"questionid"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[t.result valueForKey:@"leavemessages"] mutableCopy];
        if(mList == nil){
            mList = [[NSMutableArray alloc]init];
        }
        
        [self.tableView reloadData];
        isScroll = YES;
        [self checkBottom2];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"与\"%@\"聊天",friendname];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(message:) name:NOTIFICATION_MESSAGE object:nil];
    //[self loadNext];
    // Do any additional setup after loading the view from its nib.
}
- (void)message:(NSNotification * )n
{
//    friendId
    BOOL b = false;
    [self checkBottom];
    for (NSDictionary * dic  in n.object) {
        if([[dic valueForKey:@"senderuserid"]isEqualToString:friendId ] == YES){
            [mList addObject:dic];
            b = YES;
        }
    }
    if(b){
        [self.tableView reloadData];

    }
    [self checkBottom2];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row] ;
    
    if([[dic valueForKey:@"leavemessagetype"] intValue] == 1){
        return 170;
    }else if([[dic valueForKey:@"leavemessagetype"] intValue] == 2){
        return 60;
    }else{
        CGSize size = [[dic valueForKey:@"leavemessagecontent"] sizeWithFont:[SHSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(183, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
        return  60 - 18 + size.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mList.count > 0) {
        
        SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
        NSDictionary * dic = [mList objectAtIndex:indexPath.row];
        [intent.args setValue:[dic valueForKey:@"senderuserid"] forKey:@"friendId"];
        
        [[UIApplication sharedApplication]open:intent];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isAnimation){
//        [self.txtBox resignFirstResponder];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatUnitViewCell * cell = nil;
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if([[dic valueForKey:@"issendbyme"] integerValue] > 0 ){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitMySelfViewCell" owner:nil options:nil] objectAtIndex:0];
    }else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    if([[dic valueForKey:@"leavemessagetype"] intValue] == 2){
        cell.viewplayer.hidden = NO;
        [cell.viewplayer setUrl:[dic valueForKey:@"leavemessagecontent"]];

    }
    if([[dic valueForKey:@"leavemessagetype"] intValue] == 1){
        [cell.imgPhoto setUrl:[dic valueForKey:@"leavemessagecontent"]];
        cell.imgPhoto.hidden = NO;
    }else{
        cell.labTxt.text = [dic valueForKey:@"leavemessagecontent"];

    }
    [cell.imgIcon setUrl:[dic valueForKey:@"senderheadicon"]];
    cell.labTimer.text = [[dic valueForKey:@"leavemessagetime"] substringWithRange:NSMakeRange(11,5)];
    return cell;
}

- (IBAction)btnSenderOnTouch:(id)sender
{
    if (self.txtBox.text.length == 0) {
        return;
    }
    
    [self showWaitDialogForNetWork];
    NSString * msg = self.txtBox.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[SHEntironment instance].loginName forKey:@"senderuserid"];
    [dic setValue:@"" forKey:@"senderheadicon"];
    [dic setValue:@"" forKey:@"senderusername"];
    [dic setValue:msg forKey:@"chatcontent"];
    [dic setValue:destDateString forKey:@"sendtime"];
    [dic setValue:[NSNumber numberWithInt:1] forKey:@"issendbyme"];
    
    SHChatItem * item = [[SHChatItem alloc]init] ;
//    item.userid = friendId;
//    item.content = [NSString stringWithFormat:@"⬆︎%@",[dic valueForKey:@"chatcontent"]];
//    item.date = [dic valueForKey:@"sendtime"];
//    item.headicon = headicon;
//    item.username = friendname;
    item.isNew = NO;
    [[SHChatListHelper instance] addItem: item];
    [[SHChatListHelper instance] notice];
    
    
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:msg forKey:@"chatcontent"];
    [post.postArgs setValue:[SHEntironment instance].loginName  forKey:@"senderuserid"];
    [post.postArgs setValue:friendId  forKey:@"receiveruserid"];

    post.URL = URL_FOR(@"miSendMessage.do");
    [post start:^(SHTask *t) {
        [self dismissWaitDialog];
        [mList addObject:dic];
        [self checkBottom];
        [self.tableView reloadData];
        [self checkBottom2];
        self.txtBox.text = @"";
    } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];
    
}
@end
