//
//  SHIntentManager.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by WSheely on 14-3-5.
//  Copyright (c) 2014年 MobilityChina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHIntent.h"

@interface SHIntentManager : NSObject
//启动器
+ (void)open:(SHIntent*) intent;
+ (void)clear;
@end
