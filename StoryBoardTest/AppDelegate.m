//
//  AppDelegate.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "AppDelegate.h"

#import "EnterViewController.h"

#import "CustomTabBarController.h"
//#import "CustomNaviViewController.h"
#import <IQKeyboardManager.h>

#import "GuidePagesView.h"

#import <SSZipArchive/SSZipArchive.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGEKEY] && [[[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGEKEY] length]) {
        [NSBundle setLanguage:[[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGEKEY]];
    }
    
    //适配iOS15tableview，新增了sectionHeaderTopPadding属性，默认值是UITableViewAutomaticDimension
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = .0f;
    }
    
    //配置网络请求基本信息
    [ELBaseService addBaseUrl:@"https://can.mankebao.cn/"];
    [ELBaseService addHeader:@"USER:157_eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMDAzMTgxMDE3MDA3MDExMSIsImlhdCI6MTYxMTEwNjkzM30.WePX-kGzYsG6oUT66Ppkp-8s0pTWRg4-WI6Cvan2Tts" forKey:@"Authorization"];
    [ELBaseService addCommonPara:@{@"supplierId" : @"157", @"appChannelType" : @"2"}];
    [ELBaseService enableDebugLog:YES];
    
    [[ELLogManager sharedInstance] setup];
    [[ELLogManager sharedInstance] enableNSLog];
    [[ELLogManager sharedInstance] enableFileLog];
    #ifdef DEBUG
        [ELLogManager sharedInstance].level = ELLogLevelAll;
    #else
        [ELLogManager sharedInstance].level = ELLogLevelInfo;
    #endif
    
    //创建日志压缩文件目录
    NSString *zipDirectory = [NSString stringWithFormat:@"%@/ellogZip", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL rootPathExisted = [fileManager fileExistsAtPath:zipDirectory isDirectory:&isDirectory];
    if (!isDirectory || !rootPathExisted){
        [fileManager createDirectoryAtPath:zipDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSArray<NSString *> *logFiles = [[ELLogManager sharedInstance] exportLog];
    NSLog(@"logFile === %@", logFiles);
    if (logFiles.count) {
        //@((NSInteger)([[NSDate date] timeIntervalSince1970] * 100))
        NSString *time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"time === %@", time);
        BOOL success = [SSZipArchive createZipFileAtPath:[NSString stringWithFormat:@"%@/%@.zip", zipDirectory, time] withFilesAtPaths:logFiles withPassword:@"123456"];
        if (success) {
            //压缩成功，清除日志文件
            [[ELLogManager sharedInstance] clearLogFiles];
        }else {
            //压缩失败
        }
    }
    
    //获取压缩日志并上传
    NSError *error;
    NSArray *filesArr = [fileManager contentsOfDirectoryAtPath:zipDirectory error:&error];
    if (error) {
        NSLog(@"err === %@", error);
    }else {
        NSMutableArray *zipFiles = [NSMutableArray array];
        [filesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[obj pathExtension] isEqualToString:@"zip"]) {
                NSString *filePath = [zipDirectory stringByAppendingPathComponent:obj];
                [zipFiles addObject:filePath];
            }
        }];
        if (zipFiles.count) {
            [self uploadLogZip:zipFiles];
        }
    }
    
    //项目整体都可以实现点击间隔，如果单独修改某个 UIButton，可以设置 clickInterval 和 ignoreClickInterval
    //btn.clickInterval = 5;  btn.ignoreClickInterval = NO;
    [UIButton kk_exchangeClickMethod];
    
    [ThemeConfig clearThemeColorType];
    
    //随机引导页方式
    arc4random() % 2 ? [self controllerGuide] : [self viewGuide];
    
    [self URLTest];
    
    NSMutableArray *arr = [@[@"a", @"b", @"c", @"d", @"e"] mutableCopy];
    [@[@"1", @"1", @"1", @"2", @"2", @"2", @"3", @"4", @"5"] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"1"]) {
            NSUInteger index = [arr indexOfObject:@"a"];
            [arr insertObject:obj atIndex:index + 1];
        }else if ([obj isEqualToString:@"2"]) {
            NSUInteger index = [arr indexOfObject:@"c"];
            [arr insertObject:obj atIndex:index + 1];
        }else if ([obj isEqualToString:@"3"]) {
            NSUInteger index = [arr indexOfObject:@"d"];
            [arr insertObject:obj atIndex:index + 1];
        }else if ([obj isEqualToString:@"4"]) {
            NSUInteger index = [arr indexOfObject:@"b"];
            [arr insertObject:obj atIndex:index + 1];
        }else if ([obj isEqualToString:@"5"]) {
            NSUInteger index = [arr indexOfObject:@"e"];
            [arr insertObject:obj atIndex:index + 1];
        }
    }];
    NSLog(@"newArr === %@", arr);
    
    [self createShortcutItems];
    
    return YES;
}

- (void)URLTest {
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com:8080/share?username=123456&password=888888&errormsg=%E8%8E%B7%E5%8F%96%E5%95%86%E6%88%B7%E4%BF%A1%E6%81%AF%E5%BC%82%E5%B8%B8%5BBC2133%5D&errorcode=BC2133#page"];
    
    //[NSCharacterSet URLQueryAllowedCharacterSet]会将#转义，导致获取fragment为null
//    NSURL *url = [NSURL URLWithString:[@"https://www.baidu.com:8080/share?username=123456&password=888888&sex=男&errormsg=%E8%8E%B7%E5%8F%96%E5%95%86%E6%88%B7%E4%BF%A1%E6%81%AF%E5%BC%82%E5%B8%B8%5BBC2133%5D&errorcode=BC2133#page" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURL *url = [NSURL URLWithString:[@"https://www.baidu.com:8080/share?username=123456&password=888888&sex=男&errormsg=%E8%8E%B7%E5%8F%96%E5%95%86%E6%88%B7%E4%BF%A1%E6%81%AF%E5%BC%82%E5%B8%B8%5BBC2133%5D&errorcode=BC2133#page" stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet]]];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
    NSLog(@"scheme=%@",urlComponents.scheme);
    NSLog(@"user=%@",urlComponents.user);
    NSLog(@"password=%@",urlComponents.password);
    NSLog(@"host=%@",urlComponents.host);
    NSLog(@"port=%@",urlComponents.port);
    NSLog(@"query=%@",urlComponents.query);
    NSLog(@"fragment=%@",urlComponents.fragment);

    //包含query的各个参数
    NSLog(@"queryItems=%@",urlComponents.queryItems);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:[obj.value stringByRemovingPercentEncoding] forKey:obj.name];
    }];
    NSLog(@"newQueryItems=%@",dic);
}

- (void)controllerGuide {
    //第一种加载引导页：见EnterViewController.m
    EnterViewController *enter = [[EnterViewController alloc] init];
    CustomNaviViewController *nav = [[CustomNaviViewController alloc] initWithRootViewController:enter];
    self.window.rootViewController = nav;
}

- (void)viewGuide {
    //第二种加在window上面
    //创建TabBarController
    CustomTabBarController *tabVC = [[CustomTabBarController alloc] init];
    
    /*
    //加载Storyboard
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIStoryboard *messageSB = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    
    //设置tabBarItem
    CustomNaviViewController *homeNav = [homeSB instantiateInitialViewController];
    UIViewController *homeVc = homeNav.topViewController;
    homeVc.title = @"首页";
    homeVc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_hight_0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CustomNaviViewController *messageNav = [messageSB instantiateInitialViewController];
    UIViewController *messageVc = messageNav.topViewController;
    messageVc.title = @"聊天";
    messageVc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    messageVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_hight_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    CustomNaviViewController *mineNav = [mineSB instantiateInitialViewController];
    UIViewController *mineVc = mineNav.topViewController;
    mineVc.title = @"我的";
    mineVc.tabBarItem.image = [[UIImage imageNamed:@"tabbar_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_hight_2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建并将Storyboard添加到TabBarController中
    tabVC.viewControllers = @[homeNav,messageNav,mineNav];
    */
    //设置根控制器
    self.window.rootViewController = tabVC;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"hasLoaded"]) {
        [GuidePagesView showGuidePageViewWithImages:@[@"Guide1", @"Guide2", @"Guide3", @"Guide4"]];
//        [GuidePagesView showGuidePageViewWithImages:@[@"Guide1"]];
    }
}

- (void)uploadLogZip:(NSArray<NSString *> *)zipFiles {
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [zipFiles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            NSLog(@"idx ===== %zd", idx);
            NSError *error;
            NSURL *zipUrl = [NSURL fileURLWithPath:obj];
            NSData *logData = [NSData dataWithContentsOfURL:zipUrl options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                //转换二进制失败
            }else {
                //转换成功 上传
//                if (idx) sleep(2);
                [ELBaseService uploadDataWithUrl:@"testUpload" params:nil data:logData fileName:[zipUrl lastPathComponent] progress:^(NSProgress * _Nonnull progress) {
                    
                } handler:^(BOOL success, id  _Nonnull response, NSString * _Nonnull errorMsg) {
                    dispatch_group_leave(group);
                    NSLog(@"complete:%zd", idx);
                    if (success) {
                        //上传成功删除本地zip日志
                        [[NSFileManager defaultManager] removeItemAtPath:obj error:nil];
                    }
                }];
            }
        });
    }];
    // 多个请求都结束了，处理请求数据
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"allComplete");
    });
}

- (void)createShortcutItems {
    NSMutableArray *arrShortcutItem = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
    
    //这里要注意  不清空arrShortcutItem的话每次都会增加 但是最多只显示前4个（包括静态注册的）
    //arrShortcutItem不包括静态注册的item
    if (arrShortcutItem.count) {
        [arrShortcutItem removeAllObjects];
    }
    UIApplicationShortcutItem *shoreItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"elear.search" localizedTitle:NSLocalizedString(@"搜索", nil) localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:nil];
    [arrShortcutItem addObject:shoreItem1];
        
    UIApplicationShortcutItem *shoreItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"elear.custom" localizedTitle:NSLocalizedString(@"自定义图标", nil) localizedSubtitle:NSLocalizedString(@"副标题", nil) icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"shortcut_custom"] userInfo:@{@"name" : @"this is name", @"content" : @1}];
    [arrShortcutItem addObject:shoreItem2];
        
    [UIApplication sharedApplication].shortcutItems = arrShortcutItem;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    NSLog(@"shortcutItem === %@", [shortcutItem yy_modelToJSONString]);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
