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

//@property (nonatomic, strong) TTGTextTagConfig *config;
@property (nonatomic, copy) TTGTextTagStyle *normalStyle;
@property (nonatomic, copy) TTGTextTagStyle *selectedStyle;

@end

@implementation FoldTagTableViewCell

//- (TTGTextTagConfig *)config {
//    if (!_config) {
//        _config = [[TTGTextTagConfig alloc] init];
//        _config.textColor = [UIColor blackColor];
//        _config.selectedTextColor = [UIColor whiteColor];
//        _config.backgroundColor = [UIColor whiteColor];
//        _config.selectedBackgroundColor = [UIColor purpleColor];
//        _config.cornerRadius = _config.selectedCornerRadius = 12.5f;
//        _config.borderWidth = _config.selectedBorderWidth = 2.f;
//        _config.borderColor = [UIColor blackColor];
//        _config.selectedBorderColor = [UIColor whiteColor];
//        _config.extraSpace = CGSizeMake(20, 10);
//    }
//    return _config;
//}

- (TTGTextTagStyle *)normalStyle {
    if (!_normalStyle) {
        _normalStyle = [TTGTextTagStyle new];
        _normalStyle.backgroundColor = [UIColor whiteColor];
        _normalStyle.cornerRadius = 12.5f;
        _normalStyle.borderWidth = 2.f;
        _normalStyle.borderColor = [UIColor blackColor];
        _normalStyle.extraSpace = CGSizeMake(20, 10);
    }
    return _normalStyle;
}

- (TTGTextTagStyle *)selectedStyle {
    if (!_selectedStyle) {
        _selectedStyle = [TTGTextTagStyle new];
        _selectedStyle.backgroundColor = [UIColor purpleColor];
        _selectedStyle.cornerRadius = 12.5f;
        _selectedStyle.borderWidth = 2.f;
        _selectedStyle.borderColor = [UIColor whiteColor];
        _selectedStyle.extraSpace = CGSizeMake(20, 10);
    }
    return _selectedStyle;
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
    NSMutableArray<TTGTextTag *> *tags = [NSMutableArray arrayWithCapacity:tagsArr.count];
    [tagsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTGTextTag *tag = [TTGTextTag tagWithContent:[self tagStringContent:obj isSelected:NO] style:self.normalStyle selectedContent:[self tagStringContent:obj isSelected:YES] selectedStyle:self.selectedStyle];
        [tags addObject:tag];
    }];
//    [_tagView addTags:tagsArr withConfig:self.config];
    [_tagView addTags:tags];
    
    tagViewTopCons.constant = isFold ? 15.f : 10.f;
    tagViewBottomCons.constant = isFold ? -tagViewHeight : 20.f;
    
}

- (TTGTextTagStringContent *)tagStringContent:(NSString *)content isSelected:(BOOL)isSelected {
    return [TTGTextTagStringContent contentWithText:content textFont:[UIFont systemFontOfSize:15.f] textColor:isSelected ? [UIColor whiteColor] : [UIColor blackColor]];
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
    tagViewHeight = contentSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
