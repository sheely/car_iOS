//
//  Core.h
//  Core
//
//  Created by zywang on 13-8-17.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHSkin.h"
#import "SHPostTaskM.h"
#import "SHEntironment.h"
#import "SHTask.h"
#import "SHIIOSVersion.h"
#import "Base64.h"
#import "SHVersion.h"
#import "SHCrashManager.h"
#import "SHConfigManager.h"
#import "SHVersion.h"
#import "SHFuck.h"
#import "NSData+AES.h"
#import "NSString+MD5.h"
#import "SHUser.h"
#import "SHTools.h"
#import "IPAddress.h"
#import "SHFlowManager.h"
#import "SHLogger.h"
#import "SHCacheManager.h"
#import "SHPrivateAPI.h"
#import "SHHttpTask.h"
#import "SHIntent.h"
#import "SHModuleHelper.h"
#import "GCDAsyncSocket.h"
#import "GCDAsyncUdpSocket.h"
#import "SHMsg.h"
#import "SHMsgManager.h"
#import "SHMsgM.h"
#import "SHResMsgM.h"

//#import "wax.h"

//日志记录
#define CORE_NOTIFICATION_LOG_RECORD LOG_RECORD
//流量表更新
#define CORE_NOTIFICATION_FLOW_UPDATE SHFLOW_PUSH_UPDATE

//配置表更新
#define CORE_NOTIFICATION_CONFIG_STATUS_CHANGED @"core_notification_config_status_changed"
//触发重新登录
#define CORE_NOTIFICATION_LOGIN_RELOGIN @"core_notification_login_relogin"

//重新登录超时时间
#define CODE_RELOGIN -5
//标准异常类型
#define CORE_NET_OK  0
#define CORE_NET_ERROR -100000//无返回值
#define CORE_NET_FORMAT_ERROR -100001//格式错误
#define CORE_NET_ANALYZE_ERROR - 100002//解析错误
//#define SHLog(a) [NSString stringWithFormat:a]
#define SHLog(a,b) [SHLogger Log:[NSString stringWithFormat:a,b]]

//TCP______________________________________________________________________________________________________________________
//字节数目
#define TCP_PACKET_HEAD_LENGTH_POS 16
#define TCP_PACKET_HEAD_FLAG_POS 4
#define TCP_PACKET_VERSION_POS 4
#define TCP_PACKET_WHAT_POS 4
#define TCP_PACTKT_LENGTH_POS 4

#define TCP_PACKET_HEAD_FLAG ffff
#define TCP_HOST 192.168.1.144
#define TCP_PORT 54321
//日志
//void SHLogger(NSString *format, ...);
//void SHLogger(NSString *log);
