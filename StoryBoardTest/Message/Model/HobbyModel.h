//
//  HobbyModel.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HobbyModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *item;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *action;

@end
