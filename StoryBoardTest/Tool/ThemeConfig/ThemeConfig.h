//
//  ThemeConfig.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/9.
//  Copyright © 2020 eall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//typedef enum : NSUInteger {
//    ThemeColorTypeSpring = 30010,
//    ThemeColorTypeSummer,
//    ThemeColorTypeAutumn,
//    ThemeColorTypeWinter,
//} ThemeColorType;

typedef NS_ENUM(NSUInteger, ThemeColorType) {
    ThemeColorTypeSpring = 30010,
    ThemeColorTypeSummer,
    ThemeColorTypeAutumn,
    ThemeColorTypeWinter,
};

#define kThemeImageByName(name) [UIImage colorizeImage:[UIImage imageNamed:name] withColor:[ThemeConfig themeColor]]

//常量
//UIKIT_EXTERN const CGFloat TimeInterval;

UIKIT_EXTERN NSString *const kNotificationNameThemeChange;
//static NSString *const kNotificationNameThemeChange = @"kNotificationNameThemeChange";

@interface ThemeConfig : NSObject

+ (UIColor *)themeColor;
+ (UIColor *)getThemeColorWithType:(ThemeColorType)type;

+ (void)storeThemeColorType:(ThemeColorType)themeColorType;
+ (ThemeColorType)getThemeColorType;
+ (void)clearThemeColorType;

@end

NS_ASSUME_NONNULL_END
