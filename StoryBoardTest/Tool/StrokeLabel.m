//
//  StrokeLabel.m
//  StoryBoardTest
//
//  Created by elear on 2022/5/30.
//  Copyright © 2022 eall. All rights reserved.
//

#import "StrokeLabel.h"

@implementation StrokeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textStrokeColor = [UIColor whiteColor];
        self.textNormalColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    // 设置描边宽度
    CGContextSetLineWidth(c, 3);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    // 描边颜色
    self.textColor = _textStrokeColor;
    [super drawTextInRect:rect];
    // 文本颜色
    self.textColor = _textNormalColor;
    CGContextSetTextDrawingMode(c, kCGTextFill);
    [super drawTextInRect:rect];
}

@end
