//
//  ELFileLogger.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELFileLogger : NSObject<ELLogger>

/**
 Default value is 1024 * 256 Bytes.
 */
@property (assign, nonatomic) NSInteger maxCacheSize;

/**
 Bytes. Default value is 1024*1024*30 bytes.
 */
@property (assign, nonatomic) unsigned long long maxSingleFileSize;

/**
 Default value is 5.
 */
@property (assign, nonatomic) NSUInteger storagedDay;

/**
 Init method.

 @param path Path of log files
 @param storagedDay Storaged days of log files. Default value is 5.
 @return ELFileLogger instance
 */
- (instancetype)initWithDirectoryRootPath:(NSString *)path storagedDay:(NSUInteger)storagedDay NS_DESIGNATED_INITIALIZER;

/**
 All cached logs will be written to file immediately.
 */
- (void)writeFile;

/**
 all log files path
 @return All the log File's paths
 */
- (NSArray<NSString *> *)exportLog;

/**
 delete all log files
 */
- (void)clearLogFiles;

@end

NS_ASSUME_NONNULL_END
