//
//  HobbyTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/1.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "HobbyTableViewCell.h"

@interface HobbyTableViewCell (){
    
    __weak IBOutlet UILabel *itemAndLevelLab;
    __weak IBOutlet UILabel *timeLab;
}
@end

@implementation HobbyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HobbyModel *)model{
    
    _model = model;
    itemAndLevelLab.text = [NSString stringWithFormat:@"项目：%@\n备注：%@",model.item,model.level];
    timeLab.text = [@"年限：" stringByAppendingString:model.time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
