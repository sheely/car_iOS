//
//  UIAplication.h
//  siemens.bussiness.partner.CRM.tool
//
//  Created by WSheely on 14-3-5.
//  Copyright (c) 2014年 MobilityChina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIApplication(sheely)

//- (void) openURL:(NSString *)url;

- (void) open:(SHIntent *)intent;

- (void) openStr :(NSString*) url;

- (void) openURL2 :(NSURL*) url;

@end
