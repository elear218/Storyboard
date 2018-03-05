//
//  LoginViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/1.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)back:(UIButton *)sender {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"jumpToRegiser"]) {
        RegisterViewController *regVC = segue.destinationViewController;
        [regVC setValue:@"123456" forKey:@"titleStr"];
        return;
    }
}

@end
