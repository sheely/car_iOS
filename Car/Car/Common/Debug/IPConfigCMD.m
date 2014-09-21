//
//  IPConfigCMD.m
//  Aroundme
//
//  Created by W Sheely on 13-2-6.
//  Copyright (c) 2013年 dianping.com. All rights reserved.
//

#import "IPConfigCMD.h"

@implementation ipconfig
- (void)description{
    [NVDebugPanelController.instance addLog: @"IPConfigCMD 命令\n arg0:类型,arg1:值\n例:arg0=1 yp.api.51ping.com;\n arg0=1 URL_BATA;\n arg0=2 URL_BATA\n arg0=3 arg1=custom"];
}
- (void)execute{
    if(self.args.count >=2){
        //NVInternalSetNetworkDomain((NSString*)[self.args objectAtIndex:0], (NSString*)[self.args objectAtIndex:1]);
        [SHTask pull:[self.args objectAtIndex:0] newUrl:[self.args objectAtIndex:1]];
    }else if (self.args.count == 1){
        int type = ((NSString*)[self.args objectAtIndex:0]).integerValue;
        
        if(type == 0){
            [SHTask pull:URL_HEADER newUrl:URL_HEADER];
            [NVDebugPanelController.instance addLog:  @"domain set:DEFAULT"];
        }else if(type == 1){
            //NVInternalSetNetworkDomain(@"yp.api.dianping.com", @"yp.api.51ping.com");
            [SHTask pull:URL_HEADER newUrl:URL_BATA];
            [NVDebugPanelController.instance addLog:  [NSString stringWithFormat:@"domain set:%@",URL_BATA]];
        }else if(type == 2){
            //NVInternalSetNetworkDomain(@"yp.api.dianping.com", @"192.168.30.78:8080/yellowpage");
            [SHTask pull:URL_HEADER newUrl:URL_DEVELOPER];
            [NVDebugPanelController.instance addLog:  [NSString stringWithFormat:@"domain set:%@",URL_DEVELOPER]];
        }else if(type == 3){
            //NVInternalSetNetworkDomain(@"yp.api.dianping.com", @"192.168.30.78:8080/yellowpage");
            [SHTask pull:URL_HEADER newUrl:[self.args objectAtIndex:1]];
            [NVDebugPanelController.instance addLog:  [NSString stringWithFormat:@"domain set:%@", [self.args objectAtIndex:1]]];
        }
    }else{
        [self description];
    }
    
}
@end


@implementation ip
@end