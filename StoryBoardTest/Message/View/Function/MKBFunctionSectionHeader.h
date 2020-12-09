//
//  MKBFunctionSectionHeader.h
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/17.
//  Copyright © 2020 曹运. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBFunctionSectionHeader : UICollectionReusableView

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;

@property (nonatomic, assign) BOOL isCenterTitle;

@end

NS_ASSUME_NONNULL_END
