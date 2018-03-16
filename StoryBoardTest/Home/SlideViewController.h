//
//  SlideViewController.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/15.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DrawerType) {
    DrawerTypeDefault = 1, // 平铺划出
    DrawerTypeScale,       // 缩放划出
};
@interface SlideViewController : UIViewController

@property (nonatomic, assign) DrawerType drawerType; // 抽屉类型

@end
