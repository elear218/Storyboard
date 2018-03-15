//
//  FoldTagTableViewCell.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/14.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <TTGTextTagCollectionView.h>

typedef void(^FoldBlock)(void);
@interface FoldTagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, copy) FoldBlock tap;

- (void)setTagsArr:(NSArray<NSString *> *)tagsArr foldState:(BOOL)isFold;

@end
