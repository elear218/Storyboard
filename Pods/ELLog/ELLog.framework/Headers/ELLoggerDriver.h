//
//  ELLoggerDriver.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLogger.h"
#import "ELLogFormatter.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ELLogLevel) {
    ELLogLevelError = 0,
    ELLogLevelWarning,
    ELLogLevelInfo,
    ELLogLevelDefault,
    ELLogLevelDebug,
    ELLogLevelAll,
};

@interface ELLoggerDriver : NSObject

@property (strong, nonatomic) id <ELLogger> logger;
@property (strong, nonatomic) id <ELFormatable> formatter;
@property (assign, nonatomic) ELLogLevel level;

- (instancetype)initWithLogger:(id<ELLogger>)logger
                     formatter:(id<ELFormatable>)formatter
                         level:(ELLogLevel)level NS_DESIGNATED_INITIALIZER;

- (void)logWithType:(ELLogType)type tag:(NSString *)tag message:(NSString *)message timeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
