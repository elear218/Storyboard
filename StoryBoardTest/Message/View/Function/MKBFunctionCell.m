//
//  MKBFunctionCell.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/6/4.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "MKBFunctionCell.h"

@interface MKBFunctionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *tipImgView;
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;

@end

@implementation MKBFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1];
}

- (void)setTextFontSize:(CGFloat)textFontSize {
    _textFontSize = textFontSize;
    self.textLab.font = kFontSystem(textFontSize);
}

- (void)setOperateType:(NSInteger)operateType {
    _operateType = operateType;
    if (!operateType) {
        self.operateBtn.hidden = YES;
    }else {
        self.operateBtn.hidden = NO;
        [self.operateBtn setImage:kImageNamed(1 == operateType ? @"func_add" : @"func_delete") forState:UIControlStateNormal];
    }
}

- (IBAction)operateBtnClick:(id)sender {
    !self.operateBlock ? : self.operateBlock();
}

- (void)setFunc:(MKBFunctionModel *)func {
    _func = func;
    self.imgView.image = kImageNamed(func.imageName);
    if (func.attrTitle.length) {
        self.textLab.attributedText = func.attrTitle;
    }else
        self.textLab.text = func.title;
//    [self.textLab sizeToFit];
    if (func.isManage || func.isService) {
        self.tipImgView.hidden = NO;
        self.tipImgView.image = kImageNamed(func.isManage ? @"func_manage" : @"func_service");
    }else
        self.tipImgView.hidden = YES;
    [self layoutIfNeeded];
}

@end
