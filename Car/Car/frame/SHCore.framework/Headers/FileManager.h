//
//  FileManager.h
//  Core
//
//  Created by sheely on 13-9-25.
//  Copyright (c) 2013年 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (void)writeFile:(NSString*)file  data:(NSData *)data;

+ (NSString*)readFile:(NSString*)file ;

+ (BOOL)deleteFile:(NSString*) file;
@end
