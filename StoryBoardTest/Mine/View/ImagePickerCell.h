//
//  ImagePickerCell.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);
@interface ImagePickerCell : UICollectionViewCell

@property (nonatomic, copy) ClickBlock deleteClick;

- (void)setImage:(UIImage *)image isAdd:(BOOL)isAdd;

@end
