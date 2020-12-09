//
//  MKBFunctionModel.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/6/4.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "MKBFunctionModel.h"

@implementation MKBFunctionModel

- (void)setTag:(NSInteger)tag {
    _tag = tag;
    NSArray *infoArr = [self getInfoWithTag:tag];
    _imageName = infoArr[0];
    _title = infoArr[1];
    _isManage = [infoArr[2] boolValue];
    _isService = [infoArr[3] boolValue];
}

- (NSArray *)getInfoWithTag:(NSInteger)tag {
    NSArray *arr;
    switch (tag) {
        case ZICHAN:
            arr = @[_isQuick ? @"ic_quick_zc" : @"ic_func_zc", @"资产领用", @0, @0];
            break;
        case ZICHANGUANLI:
            arr = @[@"ic_func_zc", @"资产管理", @1, @0];
            break;
        case SHITANG:
            arr = @[@"ic_func_st", @"食堂管理", @1, @0];
            break;
        case DINGCAN:
            arr = @[@"ic_func_st", @"订餐", @0, @0];
            break;
        case HAOCAIGUANLI:
            arr = @[@"ic_func_st", @"耗材管理", @1, @0];
            break;
        case HAOCAISHENQING:
            arr = @[_isQuick ? @"ic_quick_hc" : @"ic_func_st", @"耗材申请", @0, @0];
            break;
        case HAOCAILINGYONGSHENPI:
            arr = @[@"ic_func_st", @"耗材审批", @1, @0];
            break;
        case GONGCHE:
            arr = @[@"ic_func_gc", @"公车管理", @1, @0];
            break;
        case CHELIANGSQ:
            arr = @[@"ic_func_gc", @"车辆授权", @0, @0];
            break;
        case GONGCHEYY:
            arr = @[@"ic_func_gc", @"公车预约", @0, @0];
            break;
        case TONGQINCHE:
            arr = @[_isQuick ? @"ic_quick_tqc" : @"ic_func_tqc", @"通勤车", @0, @0];
            break;
        case TONGQINCHEGUANLI:
            arr = @[@"ic_func_tqc", @"通勤车管理", @1, @0];
            break;
        case TONGQINCHESIJI:
            arr = @[@"ic_func_tqc", @"通勤车司机", @0, @1];
            break;
        case SUSHEGUANLI:
            arr = @[@"ic_func_ss", @"宿舍管理", @1, @0];
            break;
        case CHELIANGDANAN:
            arr = @[@"ic_func_cl", @"车辆档案", @1, @0];
            break;
        case SUSHESQ:
            arr = @[_isQuick ? @"ic_quick_ss" : @"ic_func_ss", @"宿舍申请", @0, @0];
            break;
        case SUSHESHENPI:
            arr = @[@"ic_func_ss", @"宿舍审批", @1, @0];
            break;
        case WODESUSHE:
            arr = @[_isQuick ? @"ic_quick_ss" : @"ic_func_ss", @"我的宿舍", @0, @0];
            break;
        case HUIYISHI:
            arr = @[@"ic_func_hys", @"会议室管理", @1, @0];
            break;
        case HUIYI:
            arr = @[@"ic_func_hys", @"会议审批", @1, @0];
            break;
        case HUIYISHIYY:
            arr = @[_isQuick ? @"ic_quick_hys" : @"ic_func_hys", @"会议室预约", @0, @0];
            break;
        case XUNJIAN:
            arr = @[@"ic_func_xj", @"巡检管理", @1, @0];
            break;
        case BAOXIU:
            arr = @[_isQuick ? @"ic_quick_bx" : @"ic_func_bx", @"报修申请", @0, @0];
            break;
        case BAOXIUSHENHE:
            arr = @[@"ic_func_bx", @"报修审核", @1, @0];
            break;
        case WEIXIUREN:
            arr = @[@"ic_func_bx", @"报修管理", @1, @0];
            break;
        case BAOXIU2:
            arr = @[_isQuick ? @"ic_quick_bx" : @"ic_func_bx", @"报修", @0, @0];
            break;
        case LINGYONG:
            arr = @[@"ic_func_ly", @"领用管理", @1, @0];
            break;
        case WUPINLY:
            arr = @[@"ic_func_ly", @"物品领用", @0, @0];
            break;
        case FANGKE:
            arr = @[_isQuick ? @"ic_quick_fk" : @"ic_func_fk", @"访客预约", @0, @0];
            break;
        case FANGKESP:
            arr = @[@"ic_func_fk", @"访客审批", @1, @0];
            break;
        case MENJIN:
            arr = @[@"ic_func_mj", @"门禁管理", @1, @0];
            break;
        case MENJINSQ:
            arr = @[@"ic_func_mj", @"门禁授权", @0, @0];
            break;
        case BANZU:
            arr = @[@"ic_func_bz", @"班组订餐", @0, @0];
            break;
        case CAIPU:
            arr = @[@"ic_func_cp", @"今日菜谱", @0, @0];
            break;
        case WEATHER:
            arr = @[@"ic_func_weather", @"天气", @0, @0];
            break;
        case MORE:
            arr = @[@"ic_func_more", @"更多", @0, @0];
            break;
        case ALL:
            arr = @[@"ic_func_all", @"全部", @0, @0];
            break;
        case QRCODE:
            arr = @[_isQuick ? @"ic_quick_qrcode" : @"ic_func_all", @"我的二维码", @0, @0];
            break;
        case XIYIUSER:
            arr = @[@"ic_func_xy", @"洗衣服务", @0, @0];
            break;
        case XIYIYUAN:
            arr = @[@"ic_func_xy", @"洗衣服务", @0, @1];
            break;
        case KAOQIN:
            arr = @[@"ic_func_kaoqin", @"我的考勤", @0, @0];
            break;
        case KAOQINSHENHE:
            arr = @[@"ic_func_shenpi", @"审批", @1, @0];
            break;
        case KUAIDI:
            arr = @[@"ic_func_kd", @"快递服务", @0, @0];
            break;
        default:
            arr = @[@"", @"", @0, @0];
            break;
    }
    return arr;
}

@end
