//
//  NSObjectAddtion.m
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-23.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "NSObjectAddtion.h"

@interface SHJump:NSObject
{
@public
    NSString * notification;
    SEL selector;
    id target;
}
@end

@implementation SHJump

- (void)dealloc
{
    [super dealloc];
}
@end

const static  NSMutableDictionary * __DIC;

@implementation NSObject(sheely)

bool(*impx)(id,SEL,NSError*);
void(*impx2)(id,SEL);

- (void)performSelector:(SEL)aSelector afterNotification:(NSString*) notification
{
    if(__DIC == NULL){
        __DIC = [[NSMutableDictionary alloc ]init];
    }
    
    NSString * clazz = [SHModuleHelper.instance targeByPreAction:notification];
    if(clazz != nil){
        Class clacc = NSClassFromString(clazz);
        SEL sel = @selector(__GET_PRE_ACTION_STATE:);
        [clacc methodForSelector:sel];
        if(impx > 0){
            NSError * error = [[[NSError alloc]init] autorelease];
            BOOL result = (BOOL)impx(clacc,sel,error);
            if (result ) {
                impx2(self,aSelector);
            }else {
                SHJump * jump = [[[SHJump alloc]init] autorelease];
                jump->target = self;
                jump->selector = aSelector;
                jump->notification = notification;
                [__DIC setValue:jump forKey:notification];
                [[NSNotificationCenter defaultCenter ] addObserver:NSClassFromString(@"NSObject") selector: @selector( notifationReceiver:) name:jump->notification object:nil];
                SHIntent * intent = [[[SHIntent alloc]init] autorelease];
                intent.target = clazz;
//                intent.container = ((UIViewController *)self).navigationController;// 
                [[UIApplication sharedApplication]open:intent];
            }
        }
    }
}


+ (void)notifationReceiver:(NSNotification* )ns
{
  
    [SHIntentManager clear];
    SHJump * jp = [__DIC valueForKey:ns.name];
    [[NSNotificationCenter defaultCenter ]removeObserver:self name:ns.name object:nil];
    impx2(jp->target,jp->selector);
    [__DIC removeObjectForKey:ns.name];
}
@end
