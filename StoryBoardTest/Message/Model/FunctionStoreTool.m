//
//  FunctionStoreTool.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

#import "FunctionStoreTool.h"
#import "MKBFunctionModel.h"

@implementation FunctionStoreTool

+ (void)storeCommonFuncTypeArray:(NSArray *)arr {
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"commonFuncArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)commonFuncTypeArray {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"commonFuncArr"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"commonFuncArr"];
    }
    return [self allFuncTypeArray];
}

+ (NSArray *)allFuncTypeArray {
    return @[@(ZICHANGUANLI),@(BAOXIUSHENHE),@(HUIYISHI),@(SUSHEGUANLI),@(HUIYISHIYY),@(ZICHAN),@(BAOXIU),@(WEIXIUREN),@(TONGQINCHE),@(TONGQINCHESIJI),@(HUIYI),@(SUSHESHENPI),@(WODESUSHE),@(DINGCAN),@(FANGKE),@(CHELIANGDANAN),@(XIYIYUAN),@(XIYIUSER),@(KAOQIN),@(KAOQINSHENHE),@(KUAIDI)];
}

+ (NSArray *)userFuncTypeArray {
    return @[@(HUIYISHIYY),@(ZICHAN),@(BAOXIU),@(TONGQINCHE),@(WODESUSHE),@(DINGCAN),@(FANGKE),@(XIYIUSER),@(KAOQIN),@(KUAIDI)];
}

+ (NSArray *)managerFuncTypeArray {
    return @[@(ZICHANGUANLI),@(BAOXIUSHENHE),@(HUIYISHI),@(SUSHEGUANLI),@(HUIYI),@(SUSHESHENPI),@(CHELIANGDANAN),@(KAOQINSHENHE)];
}

+ (NSArray *)serviceFuncTypeArray {
    return @[@(WEIXIUREN),@(TONGQINCHESIJI),@(XIYIYUAN)];
}

@end
