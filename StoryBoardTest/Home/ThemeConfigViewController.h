//
//  ThemeConfigViewController.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/10.
//  Copyright © 2020 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeConfigViewController : UIViewController

@property (nonatomic, copy) void (^themeChangeBlock)(void);
@property (nonatomic, copy) NSArray *testArr;

@end

NS_ASSUME_NONNULL_END
