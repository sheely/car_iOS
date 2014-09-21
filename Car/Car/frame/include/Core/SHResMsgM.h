//
//  SHResMsgM.h
//  Core
//
//  Created by WSheely on 14-5-15.
//  Copyright (c) 2014年 zywang. All rights reserved.
//

#import "SHMsg.h"

@interface SHResMsgM : SHMsg

@property (strong,nonatomic) NSObject * result;

@property (strong,nonatomic) Respinfo * respinfo;

@property (strong,nonatomic) NSString * response;

@end
