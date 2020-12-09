//
//  UIView+JZAnimation.m
//  CatGame
//
//  Created by 正奇晟业 on 2020/1/7.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "UIView+JZAnimation.h"



@implementation UIView (JZAnimation)
- (void)addRotateAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end
