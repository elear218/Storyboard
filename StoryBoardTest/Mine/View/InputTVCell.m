//
//  InputTVCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "InputTVCell.h"

@interface InputTVCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) CreateFormModel *createModel;
@property (nonatomic, strong) ProductFormModel *uploadModel;

@end

@implementation InputTVCell

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
        make.top.left.mas_equalTo(20);
    }];
    _titleLabel = label;
    
    UITextView *textView = [UITextView new];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:16.5f];
    [self.contentView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label).offset(-5);
        make.top.mas_equalTo(label.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    _contentTextView = textView;
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [UILabel new];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = [UIFont systemFontOfSize:16.5f];
    [textView addSubview:placeHolderLabel];
    _placeholderLabel = placeHolderLabel;
    
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)refreshContent:(CreateFormModel *)createModel uploadModel:(ProductFormModel *)uploadModel {
    _createModel = createModel;
    _uploadModel = uploadModel;
    _titleLabel.text = createModel.title;
    _placeholderLabel.text = createModel.placeholder;
    _contentTextView.text = [uploadModel valueForKey:createModel.key];
}

#pragma mark <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.markedTextRange == nil) {
        [_uploadModel setValue:textView.text forKey:_createModel.key];
    }
}

@end
