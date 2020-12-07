//
//  LimitPasteTextField.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/7.
//  Copyright © 2020 eall. All rights reserved.
//

#import "LimitPasteTextField.h"

@implementation LimitPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
