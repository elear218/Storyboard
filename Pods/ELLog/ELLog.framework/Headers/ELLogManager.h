//
//  ELLogManager.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELLogManager : NSObject

@property (strong, nonatomic, readonly) ELEngine *logEngine;

@property (assign, nonatomic) ELLogLevel level;

+ (instancetype)sharedInstance;

- (void)setup;

- (void)logWithType:(ELLogType)type tag:(NSString *)tag message:(NSString *)message;

/**
 Enable NSLog.
 启用NSLog。
 */
- (void)enableNSLog;

/**
 Disable NSLog.
 关闭NSLog。
 */
- (void)disableNSLog;

/**
 Enable file log. Logs will be written in files.
 打开文件log功能，将log写入文件
 */
- (void)enableFileLog;

/**
 Disable file log.
 关闭文件log功能
 */
- (void)disableFileLog;

/**
 All cached logs will be written to file immediately.
 将临时log写入文件保存
 */
- (void)writeFile;

/**
 all log files path
 所有日志文件路径

 @return log files' path 返回所有的log文件路径
 */
- (NSArray<NSString *> *)exportLog;

/**
 delete all log files
 删除所有日志文件
 */
- (void)clearLogFiles;

@end

NS_ASSUME_NONNULL_END
