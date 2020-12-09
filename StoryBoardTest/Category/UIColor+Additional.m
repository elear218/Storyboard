//
//  UIColor+Additional.m
//  IBoXiao_ios
//
//  Created by 于龙 on 14-3-25.
//  Copyright (c) 2014年 ___boxiao___. All rights reserved.
//

#import "UIColor+Additional.h"

@implementation UIColor (Additional)

//16进制颜色(html颜色值)字符串转为UIColor

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha {
    NSString *cString=[[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]uppercaseString];
    //Stringshouldbe6or8characters
    
    if([cString length]<6)return[UIColor blackColor];
    //strip0Xifitappears
    if([cString hasPrefix:@"0X"])cString=[cString substringFromIndex:2];
    if([cString hasPrefix:@"#"])cString=[cString substringFromIndex:1];
    if([cString length]!=6)return[UIColor blackColor];
    
    //Separateintor,g,bsubstrings
    
    NSRange range;
    range.location=0;
    range.length=2;
    NSString*rString=[cString substringWithRange:range];
    range.location=2;
    NSString*gString=[cString substringWithRange:range];
    range.location=4;
    NSString*bString=[cString substringWithRange:range];
    //Scanvalues
    unsigned int r,g,b;
    
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    
    return[UIColor colorWithRed:((float)r/255.0f)
                          green:((float)g/255.0f)
                           blue:((float)b/255.0f)
                          alpha:alpha];
}


+ (void)hexStringToColor:(NSString *)stringToConvert colorRGB:(UIColorBlock)colorRGB {
    NSString *cString=[[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]uppercaseString];
    //Stringshouldbe6or8characters
    
    if([cString length] < 6)
        colorRGB(0.0f,0.0f,0.0f);
    //strip0Xifitappears
    if([cString hasPrefix:@"0X"])cString=[cString substringFromIndex:2];
    if([cString hasPrefix:@"#"])cString=[cString substringFromIndex:1];
    if([cString length] != 6 )
        colorRGB(0.0f,0.0f,0.0f);;
    
    //Separateintor,g,bsubstrings
    
    NSRange range;
    range.location=0;
    range.length=2;
    NSString*rString=[cString substringWithRange:range];
    range.location=2;
    NSString*gString=[cString substringWithRange:range];
    range.location=4;
    NSString*bString=[cString substringWithRange:range];
    //Scanvalues
    unsigned int r,g,b;
    
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    
    colorRGB((CGFloat)r/255.0f,(CGFloat)g/255.0f,(CGFloat)b/255.0f);
}
+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.f];
}
@end
