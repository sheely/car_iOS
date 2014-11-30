//
//  SHChatDetailViewController.m
//  money
//
//  Created by sheely.paean.Nightshade on 14-6-10.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHCommentsDetailViewController.h"
#import "SHChatUnitViewCell.h"

@interface SHCommentsDetailViewController ()

@end

@implementation SHCommentsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
     											 name:UIKeyboardWillShowNotification
                                               object:nil];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.title = @"留言";
       //[self registerForKeyboardNotifications];
       // Do any additional setup after loading the view from its nib.
    [self loadNext];
}
- (void)loadNext
{
    [self showWaitDialogForNetWork];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"queryLmList.do");
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    
    [post start:^(SHTask * t) {
        mIsEnd  = YES;
        mList = [[t.result valueForKey:@"leaveMessages"] mutableCopy];
        [self.tableView reloadData];
        [self checkBottom];
        [self dismissWaitDialog];
    } taskWillTry:nil taskDidFailed:^(SHTask * t) {
        [t.respinfo show];
        [self dismissWaitDialog];
        
    }];

}

- (void)keyboardWillShown:(NSNotification*)ns
{
  
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect;
        [[[ns userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rect];
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height - rect.size.height +44-38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 30 - rect.size.height + 44 , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 30 - rect.size.height + 44 , 48, 30);
        isAnimation = YES;
        
        isScroll = YES;
        [self checkBottom2];
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (void)unregisterForKeyboardNotifications
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardDidHideNotification
												  object:nil];
}

- (void)keyboardDidHidden:(NSNotification*)ns
{
    isAnimation = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, 0,self.view.frame.size.width,
                                          self.view.frame.size.height -38);
        self.txtBox.frame = CGRectMake(3, self.view.frame.size.height - 34  , 250, 30);
        self.btnSender.frame = CGRectMake(261, self.view.frame.size.height - 34  , 48, 30);
        
    } completion:^(BOOL finished) {
        isAnimation = NO;
    }];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[[mList objectAtIndex:indexPath.row] valueForKey:@"lmContent"] sizeWithFont:[SHSkin.instance fontOfStyle:@"FontScaleMid"] constrainedToSize:CGSizeMake(183, 99999) lineBreakMode:NSLineBreakByTruncatingTail];
    return  60 - 18 + size.height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!isAnimation){
      //  [self.txtBox resignFirstResponder];
    }
}

- (void)dealloc
{
    [self unregisterForKeyboardNotifications];
}

- (UITableViewCell*)tableView:(UITableView *)tableView dequeueReusableStandardCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHChatUnitViewCell * cell = nil;
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if([[dic valueForKey:@"isSentByMe"] integerValue] > 0 ){

        cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitMySelfViewCell" owner:nil options:nil] objectAtIndex:0];
    }else{
         cell = [[[NSBundle mainBundle]loadNibNamed:@"SHChatUnitViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    
    cell.labTxt.text = [dic valueForKey:@"lmContent"];
    [cell.imgIcon setUrl:[dic valueForKey:@"lmHeadIcon"]];
    cell.labTimer.text = [[dic valueForKey:@"lmTime"] substringWithRange:NSMakeRange(11,5)];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (mList.count > 0) {
        
        SHIntent * intent = [[SHIntent alloc]init:@"chatuserdetail" delegate:nil containner:self.navigationController];
        NSDictionary * dic = [mList objectAtIndex:indexPath.row];
        [intent.args setValue:[dic valueForKey:@"leaveMessagerid"] forKey:@"friendId"];
        
        [[UIApplication sharedApplication]open:intent];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSenderOnTouch:(id)sender
{
    [self showWaitDialogForNetWork];
    NSString * msg = self.txtBox.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[SHEntironment instance].loginName forKey:@"leaveMessagerid"];
    [dic setValue:@"" forKey:@"lmHeadIcon"];
    [dic setValue:msg forKey:@"lmContent"];
    [dic setValue:destDateString forKey:@"lmTime"];
    [dic setValue:[NSNumber numberWithInt:1] forKey:@"isSentByMe"];
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    [post.postArgs setValue:[self.intent.args valueForKey:@"oppoId"] forKey:@"oppoId"];
    [post.postArgs setValue:msg forKey:@"leaveMessage"];
    
    post.URL = URL_FOR(@"lmAdd.do");
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

- (void)checkBottom{
    if(mList .count > 0){
        if(ABS((self.tableView.contentSize.height - self.tableView.frame.size.height - self.tableView.contentOffset.y) )<=5)
        {
            isScroll = YES;
        }else{
            isScroll = NO;
        }
    }
}
- (void)checkBottom2{
    if(isScroll){
        if(mList .count > 0){

        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:mList.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    }
}


@end
