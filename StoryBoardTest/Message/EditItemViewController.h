//
//  EditItemViewController.h
//  StoryBoardTest
//
//  Created by eall on 2018/4/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeItemBlock)(NSArray *itemArr);
@interface EditItemViewController : UIViewController

@property (nonatomic, copy) ChangeItemBlock changeBlock;

@end
