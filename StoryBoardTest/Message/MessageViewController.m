//
//  MessageViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/2/28.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "MessageViewController.h"
#import "TestTableViewController.h"

@interface MessageViewController ()

/**
 当前控制器的容器tableView
 */
@property (nonatomic, strong) TestTableViewController *contentVC;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"22222");
    
//    self.contentVC.tableView.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
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
    if ([segue.identifier isEqualToString:@"containerViewControllerId"] && [segue.destinationViewController isKindOfClass:[TestTableViewController class]]) {
        //找到容器tableView
        self.contentVC = segue.destinationViewController;
    }
}


@end
