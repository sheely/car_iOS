//
//  UIAplication.m
//  siemens.bussiness.partner.CRM.tool
//
//  Created by WSheely on 14-3-5.
//  Copyright (c) 2014年 MobilityChina. All rights reserved.
//

#import "UIApplicationAddtion.h"

@implementation UIApplication(sheely)

//- (void) openURL:(NSString *)url
//{
//   // [self openURL:(NSURL *)]
//}

- (void) open:(SHIntent *)intent
{
    [SHIntentManager open:intent];
}
- (void) openStr :(NSString*) url
{
    [self openURL2:[NSURL URLWithString:url]];
}

- (void) openURL2 :(NSURL*) url
{
    NSArray * args = [[url query] componentsSeparatedByString:@"&"];
    SHIntent * intent = [[SHIntent alloc]init];
    intent.module = [url host];
    for (NSString* arg  in args) {
        NSArray* a =[arg componentsSeparatedByString:@"="];
        if(a.count > 1) {
            [intent.args setValue:[a objectAtIndex:1] forKey:[a objectAtIndex:0]];
        }
    }
    [[UIApplication sharedApplication]open:intent];
}
@end
