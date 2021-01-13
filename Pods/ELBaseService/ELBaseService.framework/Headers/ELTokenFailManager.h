//
//  ELTokenFailManager.h
//  ELBaseService
//
//  Created by 正奇晟业 on 2021/1/13.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELTokenFailManager : NSObject

@property (nonatomic, assign) BOOL tokenFailFirst;

+ (ELTokenFailManager *)shareInstance;

- (void)alertTokenFail:(NSString *)errMsg;

@end

NS_ASSUME_NONNULL_END
