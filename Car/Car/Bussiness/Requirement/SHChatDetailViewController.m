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



- (void)messageChanged:(NSNotification*)n
{

    BOOL b = false;
    NSArray * array = [((SHResMsgM*)n.object).result valueForKey:@"ordernewmessage"];

    [self checkBottom];
    for (NSDictionary * dic  in array) {
        NSString * orderid = [dic valueForKey:@"orderid"];
        if([orderid isEqualToString:questionid] == YES){
            [mList addObjectsFromArray:[dic valueForKey:@"leavemessages"]];
            b = YES;
        }
    }
    if(b){
        [self.tableView reloadData];
        
    }
    [self checkBottom2];
    
}

- (void)loadNext
{
    [self showWaitDialogForNetWork];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"acceptquestiondetail.action");
    questionid = [self.intent.args valueForKey:@"questionid"];
    [post.postArgs setValue:questionid forKey:@"questionid"];
    
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

- (void)loadSkin
{
    self.btnSender.layer.cornerRadius = 5;
    self.btnSender.layer.masksToBounds  = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"与\"%@\"聊天",@"专家"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChanged:) name:@"newmessage" object:nil];
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
        cell.labTxt.hidden = YES;
        [cell.viewplayer setUrl:[dic valueForKey:@"leavemessagecontent"]];

    }
    if([[dic valueForKey:@"leavemessagetype"] intValue] == 1){
        [cell.imgPhoto setUrl:[dic valueForKey:@"leavemessagecontent"]];
        cell.imgPhoto.hidden = NO;
        cell.labTxt.hidden = YES;

    }else{
        cell.labTxt.text = [dic valueForKey:@"leavemessagecontent"];

    }
    [cell.imgIcon setUrl:[dic valueForKey:@"headurl"]];
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
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"leavemessagetype"];
    
    [dic setValue:msg forKey:@"leavemessagecontent"];
    [dic setValue:destDateString forKey:@"leavemessagetime"];
    [dic setValue:[NSNumber numberWithInt:1] forKey:@"issendbyme"];
    
    NSDictionary * dicuser = [[NSUserDefaults standardUserDefaults] valueForKey:STORE_USER_INFO];
    if([dicuser valueForKey:@"myheadicon"]){
        [dic setValue:[dicuser valueForKey:@"myheadicon"] forKey:@"headurl"];
    }else{
        [dic setValue:@"" forKey:@"headurl"];
    }

    
    SHChatItem * item = [[SHChatItem alloc]init] ;
    item.questionid = questionid;
    item.latestmessage = [NSString stringWithFormat:@"⬆︎%@",[dic valueForKey:@"leavemessagecontent"]];
    item.asktime = [dic valueForKey:@"leavemessagetime"];
    //item.imgIcon = [dic valueForKey:@"senderheadicon"];
    //item.username = friendname;
    item.isNew = NO;
    [[SHChatListHelper instance] addItem: item];
    [[SHChatListHelper instance] notice];
    
    
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:msg forKey:@"sendcontent"];
    [post.postArgs setValue:questionid  forKey:@"orderid"];
    [post.postArgs setValue:[NSNumber numberWithInt:0]  forKey:@"messagetype"];
    [post.postArgs setValue:[NSNumber numberWithInt:0]  forKey:@"leavemessagetype"];

    post.URL = URL_FOR(@"maintaincecommentadd.action");
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
