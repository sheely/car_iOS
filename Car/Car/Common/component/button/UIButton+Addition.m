//
//  UIButton+Addition.m
//  DianpingHD
//
//  Created by W Sheely on 12-5-11.
//  Copyright (c) 2012年 dianping.com. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton(Addition)

BOOL _shouldAutoCenter = NO;

- (void)setShouldAutoCenter:(BOOL)isauto
{
    if(_shouldAutoCenter != isauto)
    {
        //int i = &_shouldAutoCenter;
        //_shouldAutoCenter = type;
        if(isauto == YES)
        {
//            DPLOG(@"%d",[self retainCount]);
//            DPLOG(@"%d",[self.titleLabel retainCount]);
            [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//            DPLOG(@"%d",[self retainCount]);
//            DPLOG(@"%d",[self.titleLabel retainCount]);
            //[self ajustwidth];
        }else
        {
            [self.titleLabel removeObserver:self forKeyPath:@"text"];
        }
    }
 }
- (BOOL)shouldAutoCenter
{
    return _shouldAutoCenter;
}

- (void)adjustwidth
{
    CGSize sizeText = [self.titleLabel.text sizeWithFont: self.titleLabel.font];
    CGSize sizeImg =  self.currentImage.size ;
    self.titleEdgeInsets = UIEdgeInsetsMake(0,-sizeImg.width-7, 0, sizeImg.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0,sizeText.width+8, 0, -sizeText.width);
}

-(void) observeValueForKeyPath:(NSString *)aPath ofObject:(id)anObject change:(NSDictionary *)aChange context:(void *)aContext
{
    if([aPath caseInsensitiveCompare : @"text"] == NSOrderedSame)
    {
        if(self.titleLabel == nil)
        {
           
            return ;
        }
       [self adjustwidth];
    }
}   

@end
