//
//  FoldSectionView.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "FoldSectionView.h"

@interface FoldSectionView (){
    
    __weak IBOutlet UILabel *dateLab;
    UIView *xibView;
    NSCalendar *calendar;
    NSCalendarUnit unit;
}

@end

@implementation FoldSectionView

/**
 XIB创建会掉用
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUI];
        calendar = [NSCalendar currentCalendar];
        unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    }
    return self;
}

/**
 代码创建会掉用
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        calendar = [NSCalendar currentCalendar];
        unit = NSCalendarUnitMonth | NSCalendarUnitDay;
    }
    return self;
}

/**
 初始化
 */
- (void)setUI {
    xibView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    xibView.frame = self.bounds;
    [self addSubview:xibView];
    dateLab.layer.borderWidth = 1.5f;
    dateLab.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f].CGColor;
}

- (void)updateContent:(FoldModel *)model {
    NSDateComponents *dateCom = [calendar components:unit fromDate:model.sectionDate];
    NSString *dateStr = [NSString stringWithFormat:@"%02ld.%02ld",(long)dateCom.month,(long)dateCom.day];
    dateLab.text = dateStr;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (self.block) {
        self.block();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
