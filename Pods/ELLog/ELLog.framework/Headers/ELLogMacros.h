//
//  ELLogMacros.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#ifndef ELLogMacros_h
#define ELLogMacros_h

#define ELogWithType(type, atag, log) \
do { \
    [[ELLogManager sharedInstance] logWithType:type tag:atag message:log]; \
} while (0)
//[[ELLogManager sharedInstance] logWithType:type tag:atag message:log]

#define ELogError(tag, log) \
ELogWithType(ELLogTypeError, tag, log)
#define ELogWarning(tag, log) \
ELogWithType(ELLogTypeWarning, tag, log)
#define ELogInfo(tag, log) \
ELogWithType(ELLogTypeInfo, tag, log)
#define ELogDefault(tag, log) \
ELogWithType(ELLogTypeDefault, tag, log)
#define ELogDebug(tag, log) \
ELogWithType(ELLogTypeDebug, tag, log)

#define ELogE(log) \
ELogError(@"", log)
#define ELogW(log) \
ELogWarning(@"", log)
#define ELogI(log) \
ELogInfo(@"", log)
#define ELog(log) \
ELogDefault(@"", log)
#define ELogD(log) \
ELogDebug(@"", log)

#endif /* ELLogMacros_h */
