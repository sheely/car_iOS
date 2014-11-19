//
//  SHCleanViewCell.m
//  Car
//
//  Created by sheely.paean.Nightshade on 10/27/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCleanViewCell.h"

@implementation SHCleanViewCell
{
    float gouponPrice;
    
}
@synthesize  dicInfo = _dicInfo;
@synthesize gouponId;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadSkin
{
    [super loadSkin];
    self.btnSubmit.layer.cornerRadius = 5;
    self.btnSubmit.layer.masksToBounds  =YES;
}
- (void)setDicInfo:(NSDictionary *)dicInfo_
{
    _dicInfo = dicInfo_;
    if([[_dicInfo valueForKey:@"ishasspecialwash"] integerValue]==1){
        self.viewSpecial.hidden = NO;
        self.labSpecialDiscount.text = [NSString stringWithFormat:@"%g元",[[_dicInfo valueForKey:@"specialwashdiscountprice"] floatValue]];
        self.labSpecialOriginal.text = [NSString stringWithFormat:@"%g元",[[_dicInfo valueForKey:@"specialwashoriginalprice"] floatValue]];
    }
    NSArray * array = [_dicInfo valueForKey:@"mywashtickets"];
    for (int i = 0; i<array.count; i++) {
        NSDictionary * dic = [array objectAtIndex:i];
        if([[dic valueForKey:@"washtickettype"] integerValue] == 0){
            self.viewCoupon.hidden = NO;
            self.labCoupon.text = [NSString stringWithFormat:@"%g元优惠劵",[[dic valueForKey:@"washticketmoney"]floatValue ]];
                gouponPrice = [[dic valueForKey:@"washticketmoney"]floatValue ];
            self.gouponId = [dic valueForKey:@"washticketid"];
            break;
        }
    }
    self.labNormalDiscount.text = [NSString stringWithFormat:@"%g元",[[_dicInfo valueForKey:@"normalwashdiscountprice"] floatValue]];
    self.labNormalOriginal.text = [NSString stringWithFormat:@"%g元",[[_dicInfo valueForKey:@"normalwashoriginalprice"] floatValue]];
    [self caculater];

}
- (IBAction)btnNormalOnTouch:(id)sender {
    self.btnNormal.selected = YES;
    self.btnSpecial.selected = NO;
    [self caculater];

}

- (IBAction)btnSpecialOnTouch:(id)sender {
    self.btnNormal.selected = NO;
    self.btnSpecial.selected = YES;
    [self caculater];
}

- (void)caculater
{
    if(self.btnNormal.selected == YES){
        
        if(self.btnExtra.selected){
            float price =  [[_dicInfo valueForKey:@"normalwashoriginalprice"] floatValue]- gouponPrice;
            [self.btnSubmit setTitle:[NSString stringWithFormat:@"服务完成,在线支付立减%g元",price] forState:UIControlStateNormal];
        }else{
            float price =  [[_dicInfo valueForKey:@"normalwashoriginalprice"] floatValue]-[[_dicInfo valueForKey:@"normalwashdiscountprice"] floatValue];
            [self.btnSubmit setTitle:[NSString stringWithFormat:@"服务完成,在线支付立减%g元",price] forState:UIControlStateNormal];
        }

       
        
    }else if (self.btnSpecial.selected){
        float price =  [[_dicInfo valueForKey:@"specialwashoriginalprice"] intValue]-[[_dicInfo valueForKey:@"specialwashdiscountprice"] floatValue];
        [self.btnSubmit setTitle:[NSString stringWithFormat:@"服务完成,在线支付立减%g元",price] forState:UIControlStateNormal];
    }
    
}
- (IBAction)btnExtraOnTouch:(id)sender
{
    if(self.btnSpecial.selected){
        [self showAlertDialog:@"精洗不能使用优惠券"];
    }else{
        self.btnExtra.selected = !self.btnExtra.selected;
        
    }
    [self caculater];
}
@end
