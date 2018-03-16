//
//  SlideViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/15.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "SlideViewController.h"

#import <UIViewController+CWLateralSlide.h>
#import "ViewController.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = _drawerType == DrawerTypeDefault ? [UIColor whiteColor] : [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kCWSCREENWIDTH*0.75);
    }];
    
    UIButton *push = [UIButton buttonWithType:UIButtonTypeCustom];
    [push setBackgroundColor:[UIColor redColor]];
    [push setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:push];
    
    UIButton *present = [UIButton buttonWithType:UIButtonTypeCustom];
    [present setBackgroundColor:[UIColor orangeColor]];
    [present setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [present setTitle:@"present" forState:UIControlStateNormal];
    [present addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:present];
    
    UIButton *alert = [UIButton buttonWithType:UIButtonTypeCustom];
    [alert setBackgroundColor:[UIColor greenColor]];
    [alert setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alert setTitle:@"alert" forState:UIControlStateNormal];
    [alert addTarget:self action:@selector(alert:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:alert];
    
    UIButton *hide = [UIButton buttonWithType:UIButtonTypeCustom];
    [hide setBackgroundColor:[UIColor magentaColor]];
    [hide setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hide setTitle:@"hide" forState:UIControlStateNormal];
    [hide addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:hide];
    
    NSArray *btnArr = @[push,present,alert,hide];
    /*
     *** 控件等宽或等高排列（控件之间间距相等） ***
    //FixedItemLength：控件宽（MASAxisTypeHorizontal）/ 控件高（MASAxisTypeVertical）
    //leadSpacing：第一个控件距离父试图的左侧（MASAxisTypeHorizontal）/ 顶部（MASAxisTypeVertical）的距离
    //tailSpacing：最后一个控件距离父试图的右侧（MASAxisTypeHorizontal）/ 底部（MASAxisTypeVertical）的距离
    //控件之间等间距排列  间距根据父试图的宽/高与FixedItemLength、leadSpacing、tailSpacing计算得出
     */
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:35 leadSpacing:50 tailSpacing:100];
    
    /*
     *** 控件等间距排列（控件宽或高相等） ***
     //FixedSpacing：控件之间水平（MASAxisTypeHorizontal）/ 垂直（MASAxisTypeVertical）间距
     //leadSpacing：第一个控件距离父试图的左侧（MASAxisTypeHorizontal）/ 顶部（MASAxisTypeVertical）的距离
     //tailSpacing：最后一个控件距离父试图的右侧（MASAxisTypeHorizontal）/ 底部（MASAxisTypeVertical）的距离
     //控件等宽/高  宽/高根据父试图的宽/高与FixedSpacing、leadSpacing、tailSpacing计算得出
     */
//    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:60 leadSpacing:50 tailSpacing:100];
    
    //统一配置垂直居中
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
    }];
    // Do any additional setup after loading the view.
}

- (IBAction)push:(UIButton *)sender {
    ViewController *vc = [ViewController new];
    [self cw_pushViewController:vc];
}

- (IBAction)present:(UIButton *)sender {
    ViewController *vc = [ViewController new];
    [self cw_presentViewController:vc];
}

- (IBAction)alert:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"123" message:@"alert" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)hide:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
