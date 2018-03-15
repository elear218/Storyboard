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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    //导航条前景色
//    [self.navigationBar setBarTintColor:[UIColor redColor]];
    
    //左右按钮颜色
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    //导航栏文字属性
//    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
//    [barAttrs setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
//    [barAttrs setObject:[UIFont systemFontOfSize:16.f] forKey:NSFontAttributeName];
//    [self.navigationBar setTitleTextAttributes:barAttrs];
    
    // 手势代理
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
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
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
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
