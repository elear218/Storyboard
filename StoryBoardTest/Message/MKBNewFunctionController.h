//
//  MKBNewFunctionController.h
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/16.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "CustomBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBNewFunctionController : CustomBaseViewController

@property (nonatomic, copy) void (^updateBlock)(void);

@end

NS_ASSUME_NONNULL_END
