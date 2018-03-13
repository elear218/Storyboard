//
//  FoldSectionView.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FoldModel.h"

typedef void(^TapBlock)(void);
@interface FoldSectionView : UIView

@property (nonatomic, copy) TapBlock block;

- (void)updateContent:(FoldModel *)model;

@end
