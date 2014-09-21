//
//  NSDate+Addtion.h
//  Zambon
//
//  Created by sheely on 13-11-28.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import "SHView.h"

#import <Foundation/Foundation.h>

@interface NSDate(DateHelper)
//获取今天是星期几
- (NSInteger)dayOfWeek;
//获取每月有多少天
- (NSInteger)monthOfDay;
//本周开始时间
- (NSDate*)beginningOfWeek;
//本周结束时间
- (NSDate*)endOfWeek;
//日期添加几天
- (NSDate*)addDay:(NSInteger)day;
//日期格式化
- (NSString*)stringWithFormat:(NSString*)format;
//字符串转换成时间
+ (NSString*)stringFromString:(NSString*) string withInitFormat:(NSString*)format withFormat:(NSString*)format1;
//字符串转换成时间
+ (NSDate*)dateFromString:(NSString*) string withFormat:(NSString*)format;
//时间转换成字符串
+ (NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)string;
//日期转化成民国时间
- (NSString*)dateToTW:(NSString*)string;
//获取当前周
- (NSArray *)arrayCurWeek;
//+ (NSDate *) dateByLocal;
//是不是本周
- (BOOL)isCurrentWeek:(NSString*) string ;
//是不是本月
- (BOOL) isCurrentMonth:(NSString*) string ;
//是不是本季度
- (BOOL) isCurrentQuarter:(NSString*)  string ;
@end
