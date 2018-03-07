//
//  HomeViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/28.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "HomeViewController.h"

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
    // Do any additional setup after loading the view.
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
