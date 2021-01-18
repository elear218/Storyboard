//
//  ELEngine.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELLoggerDriver.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELEngine : NSObject

- (void)addDriver:(ELLoggerDriver *)driver;

- (void)removeDriver:(ELLoggerDriver *)driver;

- (void)removeAllDrivers;

- (void)logWithType:(ELLogType)type tag:(NSString *)tag message:(NSString *)message timeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
