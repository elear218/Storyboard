//
//  StrokeLabel.h
//  StoryBoardTest
//
//  Created by elear on 2022/5/30.
//  Copyright © 2022 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StrokeLabel : UILabel

@property (copy, nonatomic) UIColor *textStrokeColor; //文字边框颜色
@property (copy, nonatomic) UIColor *textNormalColor; //文字颜色

@end

NS_ASSUME_NONNULL_END
