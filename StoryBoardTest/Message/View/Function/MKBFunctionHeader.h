//
//  MKBFunctionHeader.h
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/16.
//  Copyright © 2020 elear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKBLittleFunctionCell.h"
#import "MKBFunctionCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBFunctionHeader : UIView

@property (nonatomic, copy) void (^editBlock)(void);
@property (nonatomic, copy) NSArray<MKBFunctionModel *> *commonFuncArr;

@end

NS_ASSUME_NONNULL_END
