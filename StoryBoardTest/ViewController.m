//
//  ViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/27.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "ViewController.h"
#import <UIViewController+CWLateralSlide.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)dismiss:(UIButton *)sender {
    if (self.view.tag != 5201314 && self.parentViewController.view.tag != 5201314) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self cw_dismissViewController];
    
//    判断当前ViewController是push还是present的方式显示的
    /*
    if (self.presentingViewController) {
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        //push方式
        [self.navigationController popViewControllerAnimated:YES];
    }
     */
    
    /*
     if (self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
     }else {
        [self dismissViewControllerAnimated:YES completion:nil];
     }
     */
    
    /*
     if ([self.navigationController.viewControllers.firstObject isEqual:self]) {
        [self dismissViewControllerAnimated:YES completion:nil];
     }else {
        [self.navigationController popViewControllerAnimated:YES];
     }
     */
    
    /*
     if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
     }else {
        [self.navigationController popViewControllerAnimated:YES];
     }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
