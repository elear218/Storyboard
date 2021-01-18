//
//  ELDateFormatter.h
//  ELLog
//
//  Created by 正奇晟业 on 2021/1/16.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELDateFormatter : NSObject

+ (instancetype)sharedInstance;

- (NSString *)dateStringWithTimeInterval:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
