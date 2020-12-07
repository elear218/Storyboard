//
//  NSString+Additional.h
//  LiveStore
//
//  Created by 于龙 on 13-11-14.
//  Copyright (c) 2013年 fm.laifu.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width maximumNumberOfLines:(int)lines;
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize;   //计算字符串宽度
+ (BOOL) isValidateEmail:(NSString *)email;
+ (BOOL) isValidateMobile:(NSString *)mobile;
+ (BOOL) isValidateIBC:(NSString *)number;//11位数字
+ (BOOL) validateCarNo:(NSString*) carNo;
+ (BOOL) isBlankString:(NSString *)string;
+ (BOOL) isValidatePhone:(NSString *)phone;
- (NSString *)URLEncodedString;
- (NSString *)removeFloatAllZero;
//金额格式化，保留两位小数
- (NSString *)formatDecimalNumber;

//富文本
- (NSAttributedString *)getAttributeStringWithColor:(UIColor *)color font:(UIFont *)font;
@end
