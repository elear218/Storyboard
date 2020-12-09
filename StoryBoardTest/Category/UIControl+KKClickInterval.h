//
//  UIControl+KKClickInterval.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/9.
//  Copyright © 2020 eall. All rights reserved.
//

//https://juejin.cn/post/6899057632716750855

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (KKClickInterval)

/// 点击事件响应的时间间隔，不设置或者小于 0 时为默认时间间隔
@property (nonatomic, assign) NSTimeInterval clickInterval;
/// 是否忽略响应的时间间隔
@property (nonatomic, assign) BOOL ignoreClickInterval;

+ (void)kk_exchangeClickMethod;

@end

NS_ASSUME_NONNULL_END
