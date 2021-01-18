//
//  ELLogFormatter.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ELLogFormatType) {
    ELLogFormatTypeNSLog = 0,
    ELLogFormatTypeFile,
};

typedef NS_ENUM(NSUInteger, ELLogType) {
    ELLogTypeError = 0,
    ELLogTypeWarning,
    ELLogTypeInfo,
    ELLogTypeDefault,
    ELLogTypeDebug,
};

@protocol ELFormatable <NSObject>
- (NSString *)completeLogWithType:(ELLogType)type
                              tag:(NSString *)tag
                          message:(NSString *)message
                     timeInterval:(NSTimeInterval)timeInterval;
@end

@interface ELLogFormatter : NSObject<ELFormatable>

+ (instancetype)formatterWithType:(ELLogFormatType)type;
+ (instancetype)NSLogFormatter;
+ (instancetype)FileFormatter;

- (instancetype)initWithType:(ELLogFormatType)type;

@end

NS_ASSUME_NONNULL_END
