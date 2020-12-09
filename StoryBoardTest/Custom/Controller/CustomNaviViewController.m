//
//  CustomNaviViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CustomNaviViewController.h"

@interface CustomNaviViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNaviViewController

+ (void)initialize {
    
    UINavigationBar *naviBar = [UINavigationBar appearance];
    
    [naviBar setTranslucent:NO]; //1️⃣
    //导航条前景色
    [naviBar setBarTintColor:[UIColor whiteColor]];  //2️⃣
    
    //解决iOS11界面缩放后导航栏空出状态栏的空隙的问题（不使用此方法 改用实现viewWillLayoutSubviews和viewDidLayoutSubviews手动修改高度  原因：设置图片要取消设置1️⃣2️⃣，导航栏颜色不易修改）
    //方案链接：https://juejin.im/post/5a6bf18ff265da3e5859947f
//    [naviBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    //左右按钮颜色
    [naviBar setTintColor:[UIColor blackColor]];
    
    //导航栏文字属性
    //    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    //    [barAttrs setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    //    [barAttrs setObject:[UIFont systemFontOfSize:16.f] forKey:NSFontAttributeName];
    //    [naviBar setTitleTextAttributes:barAttrs];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (@available(iOS 11, *)) { // xcode9新特性 可以这样判断，xcode9以下只能用UIDevice systemVersion 来判断
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        CGFloat statusH = CGRectGetHeight(statusBar.frame);
        for (UIView *view in self.navigationBar.subviews) {
            if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]) {
                NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:44 + statusH];
                heightConstraint.priority = UILayoutPriorityDefaultHigh;
                [view addConstraint:heightConstraint];
            }
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (@available(iOS 11, *)) { // xcode9新特性 可以这样判断，xcode9以下只能用UIDevice systemVersion 来判断
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        CGFloat statusH = CGRectGetHeight(statusBar.frame);
        for (UIView *view in self.navigationBar.subviews) {
            // 通过遍历获取到_UIBarBackground图层
            if ([NSStringFromClass([view class]) isEqualToString:@"_UIBarBackground"]) {
                CGRect frame = view.frame;
                frame.size.height = 44 + statusH;
                frame.origin.y = -statusH;
                view.frame = frame;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 手势代理
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count) {
        [viewController setHidesBottomBarWhenPushed:YES];
        //设置导航栏返回按钮
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
        viewController.navigationItem.leftBarButtonItem = back;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 决定是否触发手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //排除根控制器，其他所有子控制器都要触发手势
    return self.viewControllers.count > 1;
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
