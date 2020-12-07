//
//  NSString+Additional.m
//  LiveStore
//
//  Created by 于龙 on 13-11-14.
//  Copyright (c) 2013年 fm.laifu.ios. All rights reserved.
//

#import "NSString+Additional.h"

@implementation NSString (Additional)
//此方法计算结果存在10左右的误差，已在此方法进行修正值
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
//    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
//                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
//                             lineBreakMode:NSLineBreakByWordWrapping];
//    return sizeToFit.height + 10;
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return sizeToFit.height;
}

+ (CGFloat)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width maximumNumberOfLines:(int)lines
{
    CGSize maxSize = CGSizeMake(width, lines * [UIFont systemFontOfSize:fontSize].lineHeight);
//    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByTruncatingTail];
//    return size.height + 10;
    CGSize size = [value boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.height;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString;
    if (@available(iOS 9.0, *)) {
        encodedString = [encodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)self,
                                                                  (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                  NULL,
                                                                  kCFStringEncodingUTF8));
    }
    return encodedString;
}

//计算某个字符串的宽度 根据不同的字体大小
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize {
    return [value sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}].width;
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

//11位数字
+ (BOOL) isValidateIBC:(NSString *)number
{
    NSString *phoneRegex = @"^\\d{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:number];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
+ (BOOL) validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/* 判断是不是有效的座机号码 */
+ (BOOL) isValidatePhone:(NSString *)phone {
    NSString *phoneRegex = @"^(0[0-9]{2,3}/-)?([2-9][0-9]{6,7})+(/-[0-9]{1,4})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

- (NSString *)removeFloatAllZero{
    NSString * testNumber = self;
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    //价格格式化显示
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    NSString * formatterString = [formatter stringFromNumber:[NSNumber numberWithFloat:[outNumber doubleValue]]];
    //获取要截取的字符串位置
    NSRange range = [formatterString rangeOfString:@"."];
    if (range.length >0 ) {
        NSString * result = [formatterString substringFromIndex:range.location];
        if (result.length >= 4) {
            formatterString = [formatterString substringToIndex:formatterString.length - 1];
        }
    }
    return  formatterString;
}

- (NSString *)formatDecimalNumber {
    if (!self || self.length == 0) {
        return self;
    }
     
    NSNumber *number = @([self doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
     
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}

- (NSAttributedString *)getAttributeStringWithColor:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    [attriString addAttribute:NSForegroundColorAttributeName
                        value:color
                        range:NSMakeRange(0, [self length])];
    [attriString addAttribute:NSFontAttributeName
                        value:font
                        range:NSMakeRange(0, [self length])];
    return [attriString copy];
}

@end
