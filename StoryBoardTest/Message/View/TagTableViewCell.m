//
//  TagTableViewCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/12.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "TagTableViewCell.h"

@interface TagTableViewCell ()<TTGTextTagCollectionViewDelegate>

@end

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tagView.delegate = self;
    // Alignment
    _tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
    
    // Use manual calculate height
    _tagView.manualCalculateHeight = YES;
    
    // Use manual height, update preferredMaxLayoutWidth
    _tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16;
}

- (void)setTagsArr:(NSArray<NSString *> *)tagsArr selectedArr:(NSArray<NSNumber *> *)selectedArr {
    [_tagView removeAllTags];
    [_tagView addTags:tagsArr];
    
    [selectedArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_tagView setTagAtIndex:obj.integerValue selected:YES];
    }];
}

#pragma mark -- TTGTextTagCollectionViewDelegate
- (BOOL)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView canTapTag:(NSString *)tagText atIndex:(NSUInteger)index currentSelected:(BOOL)currentSelected{
    if ([_delegate respondsToSelector:@selector(selectTagAtIndex:selected:in:)]) {
        [_delegate selectTagAtIndex:index selected:currentSelected in:self];
    }
    return YES;
}

//- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected {
//    if ([_delegate respondsToSelector:@selector(selectTagAtIndex:selected:in:)]) {
//        [_delegate selectTagAtIndex:index selected:selected in:self];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
