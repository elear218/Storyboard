//
//  TagTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/12.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "TagTableViewCell.h"

@interface TagTableViewCell ()<TTGTextTagCollectionViewDelegate>

@property (nonatomic, copy) TTGTextTagStyle *normalStyle;
@property (nonatomic, copy) TTGTextTagStyle *selectedStyle;

@end

@implementation TagTableViewCell

- (TTGTextTagStyle *)normalStyle {
    if (!_normalStyle) {
        _normalStyle = [TTGTextTagStyle new];
        _normalStyle.extraSpace = CGSizeMake(20, 10);
    }
    return _normalStyle;
}

- (TTGTextTagStyle *)selectedStyle {
    if (!_selectedStyle) {
        _selectedStyle = [TTGTextTagStyle new];
        _selectedStyle.backgroundColor = [UIColor orangeColor];
        _selectedStyle.extraSpace = CGSizeMake(20, 10);
    }
    return _selectedStyle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tagView.delegate = self;
    // Alignment
    _tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
    
    // Use manual calculate height
    _tagView.manualCalculateHeight = YES;
    
    // Use manual height, update preferredMaxLayoutWidth
    _tagView.preferredMaxLayoutWidth = ScreenWidth - 16;
}

- (void)setTagsArr:(NSArray<NSString *> *)tagsArr selectedArr:(NSArray<NSNumber *> *)selectedArr {
    [_tagView removeAllTags];
    NSMutableArray<TTGTextTag *> *tags = [NSMutableArray arrayWithCapacity:tagsArr.count];
    [tagsArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TTGTextTag *tag = [TTGTextTag tagWithContent:[self tagContent:obj isSelected:NO] style:self.normalStyle selectedContent:[self tagContent:obj isSelected:YES] selectedStyle:self.selectedStyle];
        [tags addObject:tag];
    }];
    [_tagView addTags:tags];
//    [_tagView addTags:tagsArr];
    
    [selectedArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [_tagView setTagAtIndex:obj.integerValue selected:YES];
        [[_tagView getTagAtIndex:obj.integerValue] setSelected:YES];
    }];
    [_tagView reload];
}

- (TTGTextTagAttributedStringContent *)tagContent:(NSString *)content isSelected:(BOOL)isSelected {
    TTGTextTagAttributedStringContent *tagContent = [TTGTextTagAttributedStringContent contentWithAttributedText:[content getAttributeStringWithColor:isSelected ? [UIColor whiteColor] : [UIColor blackColor] font:[UIFont systemFontOfSize:15.f]]];
    return tagContent;
}

#pragma mark -- TTGTextTagCollectionViewDelegate
//- (BOOL)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
//                    canTapTag:(NSString *)tagText
//                      atIndex:(NSUInteger)index
//              currentSelected:(BOOL)currentSelected
//                    tagConfig:(TTGTextTagConfig *)config {
//    if ([_delegate respondsToSelector:@selector(selectTagAtIndex:selected:in:)]) {
//        [_delegate selectTagAtIndex:index selected:currentSelected in:self];
//    }
//    return YES;
//}

- (BOOL)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    canTapTag:(TTGTextTag *)tag
                      atIndex:(NSUInteger)index {
    if ([_delegate respondsToSelector:@selector(selectTagAtIndex:selected:in:)]) {
        [_delegate selectTagAtIndex:index selected:tag.selected in:self];
    }
    return YES;
}

//- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
//                    didTapTag:(NSString *)tagText
//                      atIndex:(NSUInteger)index
//                     selected:(BOOL)selected
//                    tagConfig:(TTGTextTagConfig *)config {
//    if ([_delegate respondsToSelector:@selector(selectTagAtIndex:selected:in:)]) {
//        [_delegate selectTagAtIndex:index selected:selected in:self];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
