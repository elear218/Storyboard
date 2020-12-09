//
//  MKBFunctionModel.h
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/6/4.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import <Foundation/Foundation.h>

//管理
//会议
static NSInteger const HUIYISHI    = 55;//会议室管理
static NSInteger const HUIYI      = 72;//会议管理
static NSInteger const HUIYISHIYY  = 66;//会议室预约
//报修
static NSInteger const BAOXIU        = 68;//报修申请
static NSInteger const BAOXIUSHENHE  = 53;//报修审核
static NSInteger const WEIXIUREN     = 69;//报修管理(维修人)
//资产
static NSInteger const ZICHAN       = 67;//资产领用
static NSInteger const ZICHANGUANLI = 51;//资产管理
//通勤车
static NSInteger const TONGQINCHE  = 70;//通勤车
static NSInteger const TONGQINCHEGUANLI  = 59;//通勤车辆管理
static NSInteger const TONGQINCHESIJI  = 71;//通勤车司机
//耗材
static NSInteger const HAOCAISHENQING  = 16;
static NSInteger const HAOCAILINGYONGSHENPI  = 17;
static NSInteger const HAOCAIGUANLI  = 61;
//宿舍
static NSInteger const SUSHEGUANLI  = 57;
static NSInteger const SUSHESHENPI  = 86;
static NSInteger const WODESUSHE  = 87;


//便捷服务
static NSInteger const XIYIUSER = 93;
static NSInteger const XIYIYUAN = 92;
//考勤
static NSInteger const KAOQIN = 94;
static NSInteger const KAOQINSHENHE = 95;
static NSInteger const KAOQINZUZHANG = 96;
//快递
static NSInteger const KUAIDI = 120;

//车辆档案
static NSInteger const CHELIANGDANAN  = 90;

static NSInteger const SHITANG     = 2;
static NSInteger const GONGCHE     = 3;
static NSInteger const SUSHE       = 5;

static NSInteger const XUNJIAN     = 7;

static NSInteger const LINGYONG    = 9;
static NSInteger const FANGKE      = 89;
static NSInteger const MENJIN      = 11;


//一键直达
static NSInteger const DINGCAN     = 88;
static NSInteger const BANZU       = 102;
static NSInteger const CAIPU       = 103;
static NSInteger const GONGCHEYY   = 104;
static NSInteger const TONGQINCHECX= 105;
static NSInteger const SUSHESQ     = 106;

static NSInteger const WUPINLY     = 108;
static NSInteger const FANGKESP    = 109;
static NSInteger const CHELIANGSQ  = 110;
static NSInteger const BAOXIU2     = 111;
static NSInteger const MENJINSQ    = 112;

static NSInteger const WEATHER     = 99;
static NSInteger const MORE        = 100;
static NSInteger const ALL         = 999;

//我的二维码
static NSInteger const QRCODE      = 10000;

NS_ASSUME_NONNULL_BEGIN

@interface MKBFunctionModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isQuick; //是否是快捷功能
@property (nonatomic, assign) BOOL isManage;
@property (nonatomic, assign) BOOL isService;
@property (nonatomic, copy) NSAttributedString *attrTitle;
@property (nonatomic, assign) NSInteger tag;

@end

NS_ASSUME_NONNULL_END
