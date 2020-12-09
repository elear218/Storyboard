//
//  AllDefines.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

#ifndef AllDefines_h
#define AllDefines_h

//自定义的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

//屏幕宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//判断ipad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//系统版本
#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]

//APP版本
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//对应bundleId
#define APP_BUNDLE_ID           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
//手机型号
#define kDeviceModel          [[UIDevice currentDevice] model]
//系统名字“iphone os”
#define kDeviceSystemName     [[[UIDevice currentDevice] systemName] lowercaseString]

#define loadNib(nibName)          ([[NSBundle mainBundle] loadNibNamed:(nibName) owner:nil options:nil].firstObject)

#define STATUSBAR_HEIGHT    [UIApplication sharedApplication].statusBarFrame.size.height

#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/*
 *系统颜色简写
 */
#define kClearColor      ([UIColor clearColor])
#define kWhiteColor      ([UIColor whiteColor])
#define kLightGrayColor  ([UIColor lightGrayColor])
#define kRedColor        ([UIColor redColor])
#define kGreenColor      ([UIColor greenColor])
#define kBlackColor      ([UIColor blackColor])
#define kGrayColor       ([UIColor grayColor])

#define kHexStrColor(color)   ([UIColor hexStringToColor:(color) alpha:1.0f])
#define kColore2e2e2   ([UIColor hexStringToColor:@"#e2e2e2" alpha:1.0f])
#define kColor333333   ([UIColor hexStringToColor:@"#333333" alpha:1.0f])
#define kColor666666   ([UIColor hexStringToColor:@"#666666" alpha:1.0f])
#define kColor999999   ([UIColor hexStringToColor:@"#999999" alpha:1.0f])
#define kColorf1f1f1   ([UIColor hexStringToColor:@"#f1f1f1" alpha:1.0f])
#define kColorf9f9f9   ([UIColor hexStringToColor:@"#f9f9f9" alpha:1.0f])

//文件系统目录
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//弱引用/强引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf(type)  __strong typeof(type) type = weak##type;

//UIColor生成
#define kRGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//字体
#define kFontSystem(size)         ([UIFont systemFontOfSize:size])
#define kFontBoldSystem(size)     ([UIFont boldSystemFontOfSize:size])
//指示器
#define HUDNormal(msg) {MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:NO];\
hud.mode = MBProgressHUDModeText;\
hud.minShowTime = 2;\
hud.detailsLabel.text = msg;\
hud.detailsLabel.font = [UIFont systemFontOfSize:15];\
[hud hideAnimated:YES afterDelay:1];\
}

//16进制颜色
#define kHexColor(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

#define APPDELEGATE         (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define isIPhoneX  [UIApplication sharedApplication].statusBarFrame.size.height >= 44

//字体
#define kFontSystem(size)         ([UIFont systemFontOfSize:size])
#define kFontBoldSystem(size)     ([UIFont boldSystemFontOfSize:size])

#define kImageNamed(imageName)     [UIImage imageNamed:(imageName)]

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* AllDefines_h */
