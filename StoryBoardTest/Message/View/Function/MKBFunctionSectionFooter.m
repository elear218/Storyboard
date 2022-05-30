//
//  MKBFunctionSectionFooter.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/17.
//  Copyright © 2020 elear. All rights reserved.
//

#import "MKBFunctionSectionFooter.h"

@interface MKBFunctionSectionFooter ()

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MKBFunctionSectionFooter

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        self.tipLab = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height - 8.f)];
        self.tipLab.textColor = kColor666666;
        self.tipLab.font = kFontSystem(12.f);
        self.tipLab.textAlignment = NSTextAlignmentCenter;
        self.tipLab.text = @"以上功能展示在首页（最多7个）";
        [self addSubview:self.tipLab];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0.f, self.tipLab.maxY, frame.size.width, 8.f)];
        self.lineView.backgroundColor = kHexStrColor(@"#F5F5F9");
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    self.tipLab.text = detailStr;
}

@end
