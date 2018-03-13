//
//  FoldModel.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/13.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RowModel;
@interface FoldModel : NSObject

@property (nonatomic, copy) NSDate *sectionDate;

@property (nonatomic, copy) NSArray<RowModel *> *rowArr;

@end

@interface RowModel : NSObject

@property (nonatomic, copy) NSDate *time;

@end
