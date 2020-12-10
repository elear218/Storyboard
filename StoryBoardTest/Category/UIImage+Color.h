//
//  UIImage+Color.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/9.
//  Copyright © 2020 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;
- (UIImage *)colorizewithColor:(UIColor *)theColor;

@end

NS_ASSUME_NONNULL_END
