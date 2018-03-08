//
//  SelectTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/7.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "SelectTableViewCell.h"

@interface SelectTableViewCell (){
    
    __weak IBOutlet UILabel *textLab;
    __weak IBOutlet UIImageView *thumbImgV;
}

@end

@implementation SelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(CheckModel *)model{
    
    _model = model;
    textLab.text = model.textStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
