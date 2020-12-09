//
//  MKBLittleFunctionCell.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/16.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "MKBLittleFunctionCell.h"

@interface MKBLittleFunctionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImgView;

@end

@implementation MKBLittleFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.f green:arc4random() % 256 / 255.f blue:arc4random() % 256 / 255.f alpha:1];
}

- (void)setFunc:(MKBFunctionModel *)func {
    _func = func;
    self.imgView.image = kImageNamed(func.imageName);
    if (func.isManage || func.isService) {
        self.tipImgView.hidden = NO;
        self.tipImgView.image = kImageNamed(func.isManage ? @"func_manage" : @"func_service");
    }else
        self.tipImgView.hidden = YES;
    self.imgView.layer.cornerRadius = self.imgView.height / 2;
    self.imgView.clipsToBounds = YES;
    [self layoutIfNeeded];
}

@end
