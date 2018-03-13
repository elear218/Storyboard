//
//  FoldModel.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "FoldModel.h"

@implementation FoldModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"rowArr" : [RowModel class]};
}

@end

@implementation RowModel

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *timestamp = dic[@"rowDate"];
    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
    _time = [NSDate dateWithTimeIntervalSince1970:[timestamp.stringValue substringToIndex:10].floatValue];
    return YES;
}

@end
