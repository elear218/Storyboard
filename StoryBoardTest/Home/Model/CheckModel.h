//
//  CheckModel.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/8.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *textStr;

@property (nonatomic, assign) BOOL checkStatus;

@end
