//
//  InputTFCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "InputTFCell.h"

@interface InputTFCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *detailField;
@property (nonatomic, strong) UIImageView *arrowImgView;

@property (nonatomic, strong) CreateFormModel *createModel;
@property (nonatomic, strong) ProductFormModel *uploadModel;

@end

@implementation InputTFCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonViews];
    }
    return self;
}

- (void)commonViews {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:17.f];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];
    _titleLabel = label;
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"icon_in"];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(20);
    }];
    _arrowImgView = imageView;
    
    UITextField *textField = [UITextField new];
    textField.font = [UIFont systemFontOfSize:16.5f];
    textField.textAlignment = NSTextAlignmentRight;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label);
        make.right.mas_equalTo(imageView.mas_left);
        make.left.mas_equalTo(label.mas_right).offset(20);
    }];
    _detailField = textField;
    
    //设置placeholder
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:16.5f] forKeyPath:@"_placeholderLabel.font"];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:242/255.f green:243/255.f blue:248/255.f alpha:1];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(.5f);
        make.left.mas_equalTo(label);
        make.right.bottom.mas_equalTo(0);
    }];
    
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal]; //设置label不被拉抻
}

- (void)refreshContent:(CreateFormModel *)createModel uploadModel:(ProductFormModel *)uploadModel {
    _createModel = createModel;
    _uploadModel = uploadModel;
    _titleLabel.text = createModel.title;
    _detailField.placeholder = createModel.placeholder;
    _detailField.text = [uploadModel valueForKey:createModel.key]; // 将uploadModel的值以KVC的方式赋给textField
    _detailField.userInteractionEnabled = createModel.cellType == CreateCellTypeFieldInput;
    switch (createModel.keyboardType) {
        case InputKeyboardTypeAll:
            _detailField.keyboardType = UIKeyboardTypeDefault;
            break;
        case InputKeyboardTypeFloat:
            _detailField.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case InputKeyboardTypeInt:
            _detailField.keyboardType = UIKeyboardTypeNumberPad;
            break;
    }
    
    [_arrowImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(createModel.isAccessory ? 20 : 0);
    }];
}

- (void)textFieldDidChange:(UITextField *)sender {
    [_uploadModel setValue:sender.text forKey:_createModel.key]; // 将textField中的值赋给_uploadModel
}

@end
