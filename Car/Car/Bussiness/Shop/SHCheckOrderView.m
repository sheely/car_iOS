//
//  SHCheckOrderView.m
//  Car
//
//  Created by sheely.paean.Nightshade on 11/23/14.
//  Copyright (c) 2014 sheely.paean.coretest. All rights reserved.
//

#import "SHCheckOrderView.h"


@implementation SHCheckOrderView

@synthesize checkticket = _checkticket;
@synthesize delegate;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCheckticket:(NSDictionary *)checkticket_
{
    _checkticket = checkticket_;
    self.labCoupon.text = [NSString stringWithFormat:@"%d元优惠券",[[self.checkticket valueForKey:@"washticketmoney"] integerValue]];
    self.btnCoupon.selected = NO;
    [self.btnSubmit setTitle:[NSString stringWithFormat:@"现在下单, 在线支付立减100元"]forState:UIControlStateNormal];
    if(_checkticket){
        self.viewCoupon.hidden = NO;
    }else{
        self.viewCoupon.hidden = YES;
    }
}

-(void)loadSkin
{
    [super loadSkin];
    self.btnSubmit.layer.cornerRadius = 5;
    self.btnSubmit.layer.masksToBounds = 5;
    self.viewBg.layer.cornerRadius = 5;
    self.viewBg.layer.masksToBounds = 5;
}

- (IBAction)btnCouponOnTouch:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if(sender.selected && self.checkticket){
        [self.btnSubmit setTitle:[NSString stringWithFormat:@"现在下单, 在线支付立减%d元",150 - [[self.checkticket valueForKey:@"washticketmoney"] intValue]]forState:UIControlStateNormal];
    }else{
        [self.btnSubmit setTitle:[NSString stringWithFormat:@"现在下单, 在线支付立减100元"]forState:UIControlStateNormal];
    }
}

- (IBAction)btnSubmitOnTouch:(id)sender {
    [self.delegate checkorderviewOnSubmit:self];
}

- (IBAction)btnCloseOnTouch:(id)sender {
    [self removeFromSuperview];
}
@end
