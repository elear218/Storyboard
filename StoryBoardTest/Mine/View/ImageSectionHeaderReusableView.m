//
//  ImageSectionHeaderReusableView.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "ImageSectionHeaderReusableView.h"

@interface ImageSectionHeaderReusableView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation ImageSectionHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonViews];
    }
    return self;
}

- (void)commonViews {
    UILabel *left = [UILabel new];
    left.font = [UIFont systemFontOfSize:17.f];
    [self addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
    }];
    _titleLabel = left;
    
    UILabel *right = [UILabel new];
    right.font = [UIFont systemFontOfSize:16.5f];
    right.textColor = [UIColor lightGrayColor];
    [self addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(left);
        make.right.mas_equalTo(-10);
    }];
    _countLabel = right;
}

- (void)setModel:(CreateFormModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    _countLabel.text = model.placeholder;
}

@end
