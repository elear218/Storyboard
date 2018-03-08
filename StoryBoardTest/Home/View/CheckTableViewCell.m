//
//  CheckTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/8.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CheckTableViewCell.h"

@interface CheckTableViewCell (){
    
    __weak IBOutlet UILabel *textLab;
    __weak IBOutlet UIButton *checkBtn;
}

@end

@implementation CheckTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CheckModel *)model{
    
    _model = model;
    
    textLab.text = model.textStr;
//    if (model.checkStatus) {
//        //选中状态
//        checkBtn.backgroundColor = [UIColor greenColor];
//        [checkBtn setTitle:@"☑" forState:UIControlStateNormal];
//        self.backgroundColor = [UIColor lightGrayColor];
//    }else {
//        //未选中状态
//        checkBtn.backgroundColor = [UIColor redColor];
//        [checkBtn setTitle:@"☒" forState:UIControlStateNormal];
//        self.backgroundColor = [UIColor whiteColor];
//    }
    
    checkBtn.backgroundColor = model.checkStatus ? [UIColor orangeColor] : [UIColor redColor];
    [checkBtn setTitle:model.checkStatus ? @"☑" : @"☒" forState:UIControlStateNormal];
    self.backgroundColor = model.checkStatus ? [UIColor lightGrayColor] : [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
