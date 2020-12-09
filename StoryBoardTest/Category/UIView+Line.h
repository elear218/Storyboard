//
//  UIView+Line.h
//  mkbReserve
//
//  Created by 正奇晟业 on 2018/12/4.
//  Copyright © 2018 正奇晟业. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Line)

- (void)drawLineWithColor:(UIColor *)color;

/**
 绘制虚线
 
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
