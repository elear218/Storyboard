//
//  ELControllerUtil.m
//  StoryBoardTest
//
//  Created by elear on 2022/5/25.
//  Copyright © 2022 eall. All rights reserved.
//

#import "ELControllerUtil.h"

@implementation ELControllerUtil

+ (UIViewController *)getTopVC {
    return [self getCurrentVCFrom:[UIApplication sharedApplication].delegate.window.rootViewController];
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        currentVC = [self getCurrentVCFrom:[rootVC presentedViewController]];
    } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
