//
//  UIViewController+ContentInset.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/8.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "UIViewController+ContentInset.h"

@implementation UIViewController (ContentInset)

- (void)contentInsetAdjustment{
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
