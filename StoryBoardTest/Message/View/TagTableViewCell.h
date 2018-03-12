//
//  TagTableViewCell.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/12.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <TTGTextTagCollectionView.h>

@class TagTableViewCell;
@protocol TagSelectDelegate <NSObject>
@optional
- (void)selectTagAtIndex:(NSInteger)idx selected:(BOOL)selected in:(TagTableViewCell *)cell;

@end

@interface TagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) id <TagSelectDelegate> delegate;

- (void)setTagsArr:(NSArray<NSString *> *)tagsArr selectedArr:(NSArray <NSNumber *>*)selectedArr;

@end
