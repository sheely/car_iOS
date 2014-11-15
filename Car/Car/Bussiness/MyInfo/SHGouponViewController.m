//
//  SHGouponViewController.m
//  Car
//
//  Created by sheely.paean.Nightshade on 14/11/14.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHGouponViewController.h"

@interface SHGouponViewController ()

@end

@implementation SHGouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    
    SHPostTaskM * p  = [[SHPostTaskM alloc]init];
    p.URL= URL_FOR(@"mywashticketsquery.action");
    [p.postArgs setValue:[NSNumber numberWithInt:99] forKey:@"tickettype"];
    [p.postArgs setValue:[NSNumber numberWithInt:0] forKey:@"isonlyexpired"];
    [p start:^(SHTask *t) {
        NSArray * array = [t.result valueForKey:@"mywashtickets"];
        for (NSDictionary * dic  in array) {
            if([[dic valueForKey:@"washtickettype"] integerValue] == 0){
                self.labCleanPrice.text = [NSString stringWithFormat:@"%d元",[[dic valueForKey:@"washticketmoney"] integerValue]];
                self.labCleanDes.text = [NSString stringWithFormat:@"洗车仅需支付%d元",[[dic valueForKey:@"washticketmoney"] integerValue]];
                self.labCleanStart.text = [[dic valueForKey:@"washticketstarttime"] substringToIndex:10];
                self.labCleanEnd.text = [[dic valueForKey:@"washticketendtime"] substringToIndex:10];
            }else{
                self.labCheckPrice.text = [NSString stringWithFormat:@"%d元",[[dic valueForKey:@"washticketmoney"] integerValue]];
                self.labCheckDec.text = [NSString stringWithFormat:@"检测仅需支付%d元",[[dic valueForKey:@"washticketmoney"] integerValue]];
                self.labCheckStart.text = [[dic valueForKey:@"washticketstarttime"] substringToIndex:10];
                self.labCheckEnd.text = [[dic valueForKey:@"washticketendtime"] substringToIndex:10];
            }
        }
    } taskWillTry:nil
    taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];
    // Do any additional setup after loading the view from its nib.
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

@end
