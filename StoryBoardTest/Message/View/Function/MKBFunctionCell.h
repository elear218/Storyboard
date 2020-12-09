//
//  MKBFunctionCell.h
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/6/4.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKBFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBFunctionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, assign) CGFloat textFontSize;
@property (nonatomic, assign) NSInteger operateType; //0：无操作  1：添加  2：删除
@property (nonatomic, copy) void (^operateBlock)(void);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeight;

@property (nonatomic, strong) MKBFunctionModel *func;

@property (nonatomic, assign) BOOL isMoving;

@end

NS_ASSUME_NONNULL_END
