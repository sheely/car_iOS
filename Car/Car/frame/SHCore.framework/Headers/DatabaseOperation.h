//
//  DatabaseOperation.h
//  Core
//
//  Created by sheely on 13-9-13.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"


@interface DatabaseOperation : NSObject {
    sqlite3 *m_sql;
    NSString *m_dbName;
}

@property(nonatomic)sqlite3* m_sql;

@property(nonatomic,retain)NSString* m_dbName;

- (BOOL)oprationTableByStms:(NSString *)sqlStr args:(NSArray * )args;

- (id)initWithDbName:(NSString*)dbname;

- (BOOL)openOrCreateDatabase:(NSString*)DbName;

- (BOOL)createTable:(NSString*)sqlCreateTable;

- (BOOL)push:(NSData *)data forKey:(NSString *)url;

- (NSArray * )fetchRowByStms:(NSString *)sqlStr args:(NSArray * )type;

- (NSArray * )fetchRowByStms:(NSString *)sqlStr whereargs:(NSArray * )args selectargs:(NSArray * )type;

- (BOOL) exec:(NSString*)sqlStr;
@end