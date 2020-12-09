//
//  UIColor+Additional.h
//  IBoXiao_ios
//
//  Created by 于龙 on 14-3-25.
//  Copyright (c) 2014年 ___boxiao___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIColorBlock)(CGFloat r,CGFloat g, CGFloat b);

@interface UIColor (Additional)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (void)hexStringToColor:(NSString *)stringToConvert colorRGB:(UIColorBlock)colorRGB;
+ (UIColor *)randomColor;

@end
