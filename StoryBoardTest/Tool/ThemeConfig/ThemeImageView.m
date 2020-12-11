//
//  ThemeImageView.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/11.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ThemeImageView.h"

@interface UIImageView ()

@end

@implementation ThemeImageView

/**
 XIB创建会掉用
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
//        [self imageColorSet];
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
//        [self imageColorSet];
        [self addObserver];
    }
    return self;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageColorSet) name:kNotificationNameThemeChange object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self imageColorSet];
}

- (void)imageColorSet {
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = [ThemeConfig themeColor];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
