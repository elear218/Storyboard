//
//  ELLog.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<ELLog/ELLog.h>)
FOUNDATION_EXPORT double ELLogVersionNumber;
FOUNDATION_EXPORT const unsigned char ELLogVersionString[];
#import <ELLog/ELLogMacros.h>
#import <ELLog/ELLogManager.h>
#import <ELLog/ELEngine.h>
#import <ELLog/ELLoggerDriver.h>
#import <ELLog/ELNSLogger.h>
#import <ELLog/ELFileLogger.h>
#import <ELLog/ELLogFormatter.h>
#else
#import "ELLogMacros.h"
#import "ELLogManager.h"
#import "ELEngine.h"
#import "ELLoggerDriver.h"
#import "ELNSLogger.h"
#import "ELFileLogger.h"
#import "ELLogFormatter.h"
#endif



