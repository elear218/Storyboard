//
//  CustomXibView.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/7.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);
@interface CustomXibView : UIView

@property (nonatomic, copy) ClickBlock block;

@end
