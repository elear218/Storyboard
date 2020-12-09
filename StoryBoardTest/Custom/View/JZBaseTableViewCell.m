//
//  JZBaseTableViewCell.m
//  JZBTCProject
//
//  Created by 正奇晟业 on 2018/7/24.
//  Copyright © 2018年 正奇晟业. All rights reserved.
//

#import "JZBaseTableViewCell.h"

@implementation JZBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (NSString *)cellId {
    return NSStringFromClass([self class]);
}


@end
