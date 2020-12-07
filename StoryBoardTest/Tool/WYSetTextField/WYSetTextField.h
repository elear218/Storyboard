//
//  WYSetTextField.h
//  JJEW_COMPANY
//
//  Created by mac JMT on 17/3/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYSetTextField : NSObject
@property (nonatomic, assign) BOOL isHaveDian;
@property (nonatomic, assign) BOOL isFirstZero;
+ (WYSetTextField *)sharedInstance;
- (BOOL)setTextFieldPureIntWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
- (BOOL)setTextFieldTwoDecimalWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
- (BOOL)setMobileTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
- (BOOL)setCodeTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
- (BOOL)setPasswordTextWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string;
@end
