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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    EnterViewController *enter = [[EnterViewController alloc] init];
    self.window.rootViewController = enter;
    
    //创建TabBarController
//    CustomTabBarController *tabVC = [[CustomTabBarController alloc] init];
    
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
//    self.window.rootViewController = tabVC;
    
    return YES;
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
