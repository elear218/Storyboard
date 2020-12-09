//
//  FunctionStoreTool.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionStoreTool : NSObject

+ (void)storeCommonFuncTypeArray:(NSArray *)arr;
+ (NSArray *)commonFuncTypeArray;
+ (NSArray *)allFuncTypeArray;
+ (NSArray *)userFuncTypeArray;
+ (NSArray *)managerFuncTypeArray;
+ (NSArray *)serviceFuncTypeArray;

@end

NS_ASSUME_NONNULL_END
