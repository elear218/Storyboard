//
//  ProductFormModel.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 上传产品模型类
 */
@interface ProductFormModel : NSObject

@property (nonatomic, copy) NSString *classification;       //分类
@property (nonatomic, copy) NSString *title;                //标题
@property (nonatomic, copy) NSString *price;                //价格
@property (nonatomic, copy) NSString *count;                //限购件数
@property (nonatomic, copy) NSString *expiry;               //有效期
@property (nonatomic, copy) NSString *support;              //支持项
@property (nonatomic, copy) NSString *descriptionContent;   //详情描述
@property (nonatomic, copy) NSArray  *mainImg;              //主图
@property (nonatomic, copy) NSArray  *cycleImg;             //轮播图
@property (nonatomic, copy) NSArray  *detailImg;            //详情图

@end

typedef enum : NSUInteger {
    CreateCellTypeFieldInput,
    CreateCellTypeClick,
    CreateCellTypeViewInput,
    CreateCellTypeChooseImage,
} CreateCellType; //Cell样式

typedef enum : NSUInteger {
    InputKeyboardTypeAll,
    InputKeyboardTypeFloat,
    InputKeyboardTypeInt,
} InputKeyboardType; //弹出键盘类型

/**
 本地基础配置模型类
 */
@interface CreateFormModel : NSObject

@property (nonatomic, copy) NSString *title;            //左侧标题
@property (nonatomic, copy) NSString *placeholder;      //右侧占位文本
@property (nonatomic, assign) BOOL isAccessory;         //是否显示右侧箭头
@property (nonatomic, assign) CreateCellType cellType;
@property (nonatomic, assign) InputKeyboardType keyboardType;
@property (nonatomic, copy) NSString *key;              //对应上传模型的属性
@property (nonatomic, assign) NSInteger imgMaxCount;    //最大选取图片数量

@end
