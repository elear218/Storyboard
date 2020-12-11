//
//  ThemeButton.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/11.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ThemeButton.h"

@implementation ThemeButton

/**
 XIB创建会掉用
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
//        [self textColorSet];
        [self addObserver];
    }
    return self;
}

/**
 代码创建会掉用
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self textColorSet];
        [self addObserver];
    }
    return self;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorSet) name:kNotificationNameThemeChange object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self themeColorSet];
}

- (void)themeColorSet {
    //TODO: 无法处理setBackgroundImage
    [self setTitleColor:[ThemeConfig themeColor] forState:UIControlStateNormal];
    self.imageView.image = [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = [ThemeConfig themeColor];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
