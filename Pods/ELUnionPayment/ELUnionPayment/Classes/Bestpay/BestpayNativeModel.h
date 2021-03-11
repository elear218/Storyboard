//
//  BestpayNativeModel.h
//  H5ContainerFramework
//
//  Created by jackzhou on 08/03/15.
//  Copyright (c) 2015 tydic. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BestpayNativeModel : NSObject

// 订单详细信息，具体参数和拼接规则请阅览《接口文档》及SDK使用文档
@property (nonatomic,strong)NSString * orderInfo;

// 商户APP scheme, 以供回调所用
@property (nonatomic,strong)NSString * scheme;
// 商户APP 申请的密码唯一表示License
@property (nonatomic,strong)NSString * keyboardLicense;
@end
