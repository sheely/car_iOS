//
//  SHShopInfoViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 9/25/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHShopInfoViewController.h"
#import "SHCleanViewCell.h"

@interface SHShopInfoViewController ()
{
    NSDictionary * dic;
}
@end

@implementation SHShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商户详情";
    
    [self showWaitDialogForNetWork];
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"shopdetail.action");
    [post.postArgs setValue:[self.intent.args valueForKey:@"shopid"] forKey:@"shopid"];
    [post start:^(SHTask *t) {
        dic = (NSDictionary*)t.result;
        self.labName.text = [dic valueForKey:@"shopname"];
        self.labAddress.text = [dic valueForKey:@"shopaddress"];
        self.labScore.text = [NSString stringWithFormat:@"%@ 分",[[dic valueForKey:@"shopscore"] stringValue]];
        [self.imgHead setUrl:[dic valueForKey:@"shoplogo"]];
        int score = [[dic valueForKey:@"shopscore"] integerValue];
        switch (score) {
           
            case 5:
                self.img5.image = [SHSkin.instance image:@"star_selected.png"];
            case 4:
                self.img4.image = [SHSkin.instance image:@"star_selected.png"];
            case 3:
                self.img3.image = [SHSkin.instance image:@"star_selected.png"];
            case 2:
                self.img2.image = [SHSkin.instance image:@"star_selected.png"];
            case 1:
                self.img1.image = [SHSkin.instance image:@"star_selected.png"];
                break;
                
            default:
                break;
        }
        
        
        [self dismissWaitDialog];
        } taskWillTry:nil taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
    }];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadSkin
{
    [super loadSkin];
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHCleanViewCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SHCleanViewCell" owner:nil options:nil]objectAtIndex:0];
    return cell;
}

- (IBAction)btnContact:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%d",[[dic valueForKey:@"shopmobile"] integerValue]]]];

}
@end
