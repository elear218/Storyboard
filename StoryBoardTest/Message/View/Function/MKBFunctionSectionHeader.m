//
//  MKBFunctionSectionHeader.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/17.
//  Copyright © 2020 曹运. All rights reserved.
//

#import "MKBFunctionSectionHeader.h"

@interface MKBFunctionSectionHeader ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;

@end

@implementation MKBFunctionSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        self.clipsToBounds = YES;
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 0.f, frame.size.height)];
        self.titleLab.textColor = kColor333333;
        self.titleLab.font = [UIFont systemFontOfSize:15.f weight:UIFontWeightMedium];
        [self addSubview:self.titleLab];
        
        self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0, 0.f, frame.size.height)];
        self.detailLab.textColor = kColor666666;
        self.detailLab.font = kFontSystem(12.f);
        [self addSubview:self.detailLab];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
    [self.titleLab sizeToFit];
    self.titleLab.centerY = self.height / 2 + 5.f;
}

- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    self.detailLab.text = detailStr;
    [self.detailLab sizeToFit];
    self.detailLab.x = self.titleLab.maxX + 2.f;
    self.detailLab.centerY = self.titleLab.centerY;
}

- (void)setIsCenterTitle:(BOOL)isCenterTitle {
    _isCenterTitle = isCenterTitle;
    if (isCenterTitle) {
        self.titleLab.centerX = self.width / 2;
    }
}

@end
