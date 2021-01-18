//
//  ELLogger.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ELLogger<NSObject>

+ (instancetype)logger;

- (void)log:(NSString *)logString;

@end
