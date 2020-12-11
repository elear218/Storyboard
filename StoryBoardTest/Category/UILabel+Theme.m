//
//  UILabel+Theme.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/11.
//  Copyright © 2020 eall. All rights reserved.
//

#import "UILabel+Theme.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic, assign) BOOL isNotifyTheme;

@end

@implementation UILabel (Theme)

- (void)setIsNotifyTheme:(BOOL)isNotifyTheme {
    objc_setAssociatedObject(self, _cmd, @(isNotifyTheme), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isIsNotifyTheme {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTheme:(BOOL)isTheme {
    self.isNotifyTheme = isTheme;
    if (isTheme) {
        [self textColorSet];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textColorSet) name:kNotificationNameThemeChange object:nil];
    }
}

- (BOOL)isTheme {
    return self.isNotifyTheme;
}

- (void)textColorSet {
    self.textColor = [ThemeConfig themeColor];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNameThemeChange object:nil];
}

@end
