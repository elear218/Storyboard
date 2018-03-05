//
//  CodePushViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CodePushViewController.h"

@interface CodePushViewController ()

@end

@implementation CodePushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.receivedArr enumerateObjectsUsingBlock:^(HobbyModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"item:%@,level:%@,time:%@",obj.item,obj.level,obj.time);
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
