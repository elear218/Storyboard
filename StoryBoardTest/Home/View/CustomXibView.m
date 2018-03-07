//
//  CustomXibView.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/7.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CustomXibView.h"

@interface CustomXibView (){
    
    UIView *xibView;
}
@end

@implementation CustomXibView

/**
 XIB创建会掉用
 */
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUI];
    }
    return self;
}

/**
 代码创建会掉用
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

/**
 初始化
 */
- (void)setUI{
    xibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    xibView.frame = self.bounds;
    [self addSubview:xibView];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/**
 自动适配大小
 */
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    xibView.frame = self.bounds;
//}

@end
