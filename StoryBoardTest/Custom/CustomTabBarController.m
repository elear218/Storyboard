//
//  CustomTabBarController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CustomTabBarController.h"

#import "CustomNaviViewController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor colorWithRed:241/255.f green:97/255.f blue:95/255.f alpha:1];
    self.tabBar.translucent = NO;
    
    //创建并将Storyboard添加到TabBarController中
    self.viewControllers = [self setViewControllersWithStoryboard:@[@"Home", @"Message", @"Mine"]];
    // Do any additional setup after loading the view.
}

/**
 创建多个storyboard

 @param storyboardArr 故事版名称
 @return 多个storyboard的数组
 */
- (NSArray<__kindof UIViewController *> *)setViewControllersWithStoryboard:(NSArray<NSString *> *)storyboardArr{
    
    NSMutableArray *vcMutArr = [NSMutableArray arrayWithCapacity:storyboardArr.count];
    
    NSArray *titleArr = @[@"首页", @"聊天", @"我的"];
    [storyboardArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        //加载Storyboard
        UIStoryboard *sb = [UIStoryboard storyboardWithName:obj bundle:nil];
        
        //设置tabBarItem
        CustomNaviViewController *navi = [sb instantiateInitialViewController];
        UIViewController *vc = navi.topViewController;
        vc.title = titleArr[idx];
        vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%lu",(unsigned long)idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_hight_%lu",(unsigned long)idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [vcMutArr addObject:navi];
    }];
    
    return vcMutArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
