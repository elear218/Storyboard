//
//  HomeViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/28.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "HomeViewController.h"
#import <UIViewController+CWLateralSlide.h>
#import "YYFPSLabel.h"

#import "SlideViewController.h"
#import "CustomXibView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat navigationHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    NSLog(@"navigationHeight:%f\ntabBarHeight:%f",navigationHeight,tabBarHeight);
    
    CustomXibView *view = [[CustomXibView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    
    YYFPSLabel *fpsLab = [YYFPSLabel new];
    [[UIApplication sharedApplication].keyWindow addSubview:fpsLab];
    [fpsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    
    //iOS8上手势滑动闪动 只在9.0以上的系统开启手势滑动
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0) {
        WeakSelf(self);
        // 第一个参数为是否开启边缘手势，开启则默认从边缘50距离内有效，第二个block为手势过程中我们希望做的操作
        [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
            StrongSelf(self);
            //NSLog(@"direction = %ld", direction);
            if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
                [self showLeftSlide:nil];
            }else if (direction == CWDrawerTransitionFromRight) { //右侧滑出
                [self showRightSlide:nil];
            }
        }];
    }
    // Do any additional setup after loading the view.
}

- (IBAction)showLeftSlide:(id)sender {
    SlideViewController *slide = [SlideViewController new];
    slide.drawerType = DrawerTypeDefault;
    
    [self cw_showDrawerViewController:slide animationType:CWDrawerAnimationTypeDefault configuration:nil];
//    [self cw_showDrawerViewController:slide animationType:CWDrawerAnimationTypeMask configuration:nil];
}

- (IBAction)showRightSlide:(id)sender {
    SlideViewController *slide = [SlideViewController new];
    
    //缩放效果在iOS11上顶部状态栏会有20像素灰色  解决办法见CustomNaviViewController
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight;
    conf.backImage = [UIImage imageNamed:@"0.jpg"];
    conf.scaleY = 0.8;
    slide.drawerType = DrawerTypeScale;
    [self cw_showDrawerViewController:slide animationType:CWDrawerAnimationTypeDefault configuration:conf];
    
//    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
//    conf.direction = CWDrawerTransitionFromRight;
//    slide.drawerType = DrawerTypeDefault;
//    [self cw_showDrawerViewController:slide animationType:CWDrawerAnimationTypeMask configuration:conf];
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
