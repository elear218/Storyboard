//
//  FoldTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "FoldTableViewCell.h"

@interface FoldTableViewCell (){
    
    __weak IBOutlet UIImageView *circleImgV;
    __weak IBOutlet UIView *lineView;
    __weak IBOutlet UILabel *timeLab;
    
    NSCalendar *calendar;
    NSCalendarUnit unit;
}

@end

@implementation FoldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    calendar = [NSCalendar currentCalendar];
    unit = NSCalendarUnitHour | NSCalendarUnitMinute;
}

- (void)setModel:(RowModel *)model {
    _model = model;
    NSDateComponents *dateCom = [calendar components:unit fromDate:model.time];
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",(long)dateCom.hour,(long)dateCom.minute];
    timeLab.text = timeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    circleImgV.image = [UIImage imageNamed:selected?@"time_seleted":@"time_normal"];
    lineView.backgroundColor = selected?kHexColor(0xFEF00B):kHexColor(0x34E5FE);
    // Configure the view for the selected state
}

@end
