//
//  ThemeConfig.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/9.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ThemeConfig.h"

//const CGFloat TimeInterval = 5.f;

NSString *const kNotificationNameThemeChange = @"kNotificationNameThemeChange";

static NSString *const themeColorTypeKey = @"themeColorType";

@implementation ThemeConfig

+ (UIColor *)themeColor {
    ThemeColorType type = [self getThemeColorType];
    return [self getThemeColorWithType:type];
}

+ (UIColor *)getThemeColorWithType:(ThemeColorType)type {
    switch (type) {
        case ThemeColorTypeSpring:
            return kHexStrColor(@"#F1615F");
        case ThemeColorTypeSummer:
            return kHexStrColor(@"#04A936");
        case ThemeColorTypeAutumn:
            return kHexStrColor(@"#FF9D6F");;
        case ThemeColorTypeWinter:
            return kHexStrColor(@"#ACD6FF");
    }
}

+ (void)storeThemeColorType:(ThemeColorType)themeColorType {
    [[NSUserDefaults standardUserDefaults] setObject:@(themeColorType) forKey:themeColorTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (ThemeColorType)getThemeColorType {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:themeColorTypeKey]) {
//        return ThemeColorTypeSpring;
        ThemeColorType type = arc4random() % 4 + ThemeColorTypeSpring;
        [self storeThemeColorType:type];
        return type;
    }
    return [[[NSUserDefaults standardUserDefaults] objectForKey:themeColorTypeKey] integerValue];
}

+ (void)clearThemeColorType {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:themeColorTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
