//
//  ImagePickerCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "ImagePickerCell.h"

@interface ImagePickerCell ()

@property (nonatomic, strong) UIImageView *pickerImgView;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation ImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonViews];
    }
    return self;
}

- (void)commonViews {
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    _pickerImgView = imageView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
    button.hidden = YES;
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.size.mas_equalTo(20);
    }];
    _deleteButton = button;
}

- (void)setImage:(UIImage *)image isAdd:(BOOL)isAdd {
    _pickerImgView.image = image;
    _deleteButton.hidden = isAdd;
}

- (void)btnClick:(UIButton *)sender {
    if (self.deleteClick) {
        self.deleteClick();
    }
}

@end
