//
//  WYSetTextField.m
//  JJEW_COMPANY
//
//  Created by mac JMT on 17/3/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "WYSetTextField.h"

static NSString *const PASSWORD_CHAR = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ~`!@#$%^&*()_+-=[]|{};':\",./<>?{,}/";

@implementation WYSetTextField

static WYSetTextField *_shareInstance = nil;

+ (WYSetTextField *)sharedInstance {
    
    if (!_shareInstance) {
        
        _shareInstance = [[WYSetTextField alloc] init];
    }
    return _shareInstance;
}
- (BOOL)setMobileTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    //        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //
    //        if ([toBeString length] > 11) {
    //            textField.text = [toBeString substringToIndex:11];
    //            return NO;
    //        }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];
        if (single >='0' && single<='9')
        {
            NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if ([toBeString length] > 11) {
                textField.text = [toBeString substringToIndex:11];
                return NO;
            }
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)setCodeTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([toBeString length] > 6) {
        textField.text = [toBeString substringToIndex:6];
        return NO;
    }
    return YES;
}

- (BOOL)setTextFieldPureIntWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![string isEqualToString:filtered]) {
        return NO;
    }
    if ([string length]) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ('0' == single && !range.location) {
            //首位不能为0
            return NO;
        }
    }
    //限制长度
//    if (textField.text.length == 10) {
//        return NO;
//    }
    return YES;
}

- (BOOL)setTextFieldTwoDecimalWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian = NO;
    }
    if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
        _isFirstZero = NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![string isEqualToString:filtered]) {
        return NO;
    }
    
    if ([string length]) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
//            if([textField.text length]==0) {
            if (!range.location) {
                if (single == '.') {
                    //首字母不能为小数点
                    if (_isHaveDian) {
                        return NO;
                    }
                    NSInteger count = MIN(2, textField.text.length);
                    textField.text = [@"0." stringByAppendingString:[textField.text substringToIndex:count]];
                    _isHaveDian = YES;
                    return NO;
                }
                if (single == '0') {
                    if (!_isHaveDian && [textField.text length]) {
                        return NO;
                    }
                    NSArray *arr = [textField.text componentsSeparatedByString:@"."];
                    if (2 == arr.count && [arr.firstObject length]) {
                        return NO;
                    }
                    _isFirstZero = YES;
                    return YES;
                }
            }
            
            if (single=='.') {
                if (!_isHaveDian)//text中还没有小数点
                {
                    _isHaveDian = YES;
                    return YES;
                }
                return NO;
            }else if (single=='0') {
                if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                    //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                    if ([textField.text isEqualToString:@"0.0"]) {
                        return NO;
                    }
                    NSRange ran = [textField.text rangeOfString:@"."];
                    int tt = (int)(range.location-ran.location);
                    if (tt <= 2) {
                        return YES;
                    }else {
                        return NO;
                    }
                }else if (_isFirstZero&&!_isHaveDian) {
                    //首位有0没.不能再输入0
                    return NO;
                }else {
                    return YES;
                }
            }else {
                if (_isHaveDian) {
                    //存在小数点，保留两位小数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    int tt = (int)(range.location-ran.location);
                    if (tt <= 2) {
                        return YES;
                    }else {
                        return NO;
                    }
                }else if (_isFirstZero&&!_isHaveDian) {
                    //首位有0没点
                    return NO;
                }else{
                    return YES;
                }
            }
        }else {
            //输入的数据格式不正确
            return NO;
        }
    }
    return YES;
}

- (BOOL)setPasswordTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    if ([string isEqualToString:@""] || [string isEqualToString:@"\n"]) {
        return YES;
    }
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:PASSWORD_CHAR];
    NSCharacterSet *cs = [charSet invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
@end
