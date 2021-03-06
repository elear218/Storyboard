//
//  FoldTagTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/14.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "FoldTagTableViewCell.h"

@interface FoldTagTableViewCell ()<TTGTextTagCollectionViewDelegate>{
    
//    __weak IBOutlet NSLayoutConstraint *containerViewLeadingCons;
    __weak IBOutlet NSLayoutConstraint *buttonLeadingCons;
    __weak IBOutlet NSLayoutConstraint *tagViewTopCons;
    __weak IBOutlet NSLayoutConstraint *tagViewBottomCons;
//    __weak IBOutlet UIView *containerView;
    CGFloat tagViewHeight;
}

@property (nonatomic, strong) TTGTextTagConfig *config;

@end

@implementation FoldTagTableViewCell

- (TTGTextTagConfig *)config {
    if (!_config) {
        _config = [[TTGTextTagConfig alloc] init];
        _config.textColor = [UIColor blackColor];
        _config.selectedTextColor = [UIColor whiteColor];
        _config.backgroundColor = [UIColor whiteColor];
        _config.selectedBackgroundColor = [UIColor purpleColor];
        _config.cornerRadius = _config.selectedCornerRadius = 12.5f;
        _config.borderWidth = _config.selectedBorderWidth = 2.f;
        _config.borderColor = [UIColor blackColor];
        _config.selectedBorderColor = [UIColor whiteColor];
        _config.extraSpace = CGSizeMake(20, 10);
    }
    return _config;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    containerView.layer.borderWidth = 2.5f;
//    containerView.layer.borderColor = [UIColor grayColor].CGColor;
//    containerView.layer.cornerRadius = 5.f;
//    containerView.clipsToBounds = YES;
    
    _tagView.delegate = self;
    // Alignment
    _tagView.alignment = TTGTagCollectionAlignmentLeft;
    
    // Use manual calculate height
    _tagView.manualCalculateHeight = YES;
    
    // Use manual height, update preferredMaxLayoutWidth
    _tagView.preferredMaxLayoutWidth = ScreenWidth - 2*buttonLeadingCons.constant;
}

- (IBAction)onClick:(UIButton *)sender {
    if (self.tap) {
        self.tap();
    }
}

- (void)setTagsArr:(NSArray<NSString *> *)tagsArr foldState:(BOOL)isFold{
    [_tagView removeAllTags];
    [_tagView addTags:tagsArr withConfig:self.config];
    
    tagViewTopCons.constant = isFold ? 15.f : 10.f;
    tagViewBottomCons.constant = isFold ? -tagViewHeight : 20.f;
    
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
    tagViewHeight = contentSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
