//
//  AlipayItemModel.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "AlipayItemModel.h"

@implementation AlipayItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"identifer": @[@"id", @"ID", @"Id"]};
}

@end
