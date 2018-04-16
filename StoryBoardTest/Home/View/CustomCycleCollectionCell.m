//
//  CustomCycleCollectionCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CustomCycleCollectionCell.h"

@implementation CustomCycleCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 10.f;
    self.contentView.layer.masksToBounds = YES;
    
    self.imgView = [UIImageView new];
    self.imgView.layer.cornerRadius = 5.f;
    self.imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(CGRectGetHeight(self.bounds)/1.5);
        make.width.mas_equalTo(self.imgView.mas_height).multipliedBy(1.5);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.imgView.mas_left).offset(20);
        make.centerY.mas_equalTo(self.imgView);
    }];
}

@end



@implementation CustomTextCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.6f];
    
    self.textLabel = [UILabel new];
    self.textLabel.numberOfLines = 2;
    self.textLabel.font = [UIFont systemFontOfSize:15.f];
    self.textLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
