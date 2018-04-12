//
//  EnterViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/11.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "EnterViewController.h"
#import "CustomTabBarController.h"
#import "GuideViewController.h"

@interface EnterViewController (){
    BOOL isFirst;
}

@end

@implementation EnterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //第二种加载引导页：页面跳转
    if (!isFirst) {
        isFirst = YES;
        GuideViewController *guide = [[GuideViewController alloc] init];
        [self.navigationController pushViewController:guide animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *descLabel = [UILabel new];
    descLabel.text = @"     切换根数图转场方式:      ";
    descLabel.font = [UIFont boldSystemFontOfSize:13.5f];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(35);
    }];
    
    NSDictionary *dic = @{
                          @"type" : @[@"UIViewAnimationOptionTransitionNone", @"UIViewAnimationOptionTransitionFlipFromLeft", @"UIViewAnimationOptionTransitionFlipFromRight", @"UIViewAnimationOptionTransitionCurlUp", @"UIViewAnimationOptionTransitionCurlDown", @"UIViewAnimationOptionTransitionCrossDissolve", @"UIViewAnimationOptionTransitionFlipFromTop", @"UIViewAnimationOptionTransitionFlipFromBottom"],
                          
                          @"option" : @[
                                  @(UIViewAnimationOptionTransitionNone), @(UIViewAnimationOptionTransitionFlipFromLeft), @(UIViewAnimationOptionTransitionFlipFromRight), @(UIViewAnimationOptionTransitionCurlUp), @(UIViewAnimationOptionTransitionCurlDown), @(UIViewAnimationOptionTransitionCrossDissolve), @(UIViewAnimationOptionTransitionFlipFromTop), @(UIViewAnimationOptionTransitionFlipFromBottom)]
                          };
    
    NSMutableArray *btnArr = [NSMutableArray arrayWithCapacity:[dic[@"type"] count]];
    for (int i = 0; i < [dic[@"type"] count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        btn.tag = [dic[@"option"][i] unsignedIntegerValue];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13.5f];
        btn.layer.cornerRadius = 5.f;
        [btn setTitle:dic[@"type"][i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(enterMain:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btnArr addObject:btn];
    }
    
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:45.f leadSpacing:80 tailSpacing:120];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
    }];
    // Do any additional setup after loading the view.
}

- (void)enterMain:(UIButton *)sender {
    CustomTabBarController *tab = [[CustomTabBarController alloc] init];
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:.8f options:sender.tag animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        [UIView setAnimationsEnabled:oldState];
    } completion:^(BOOL finished){

    }];
    
}

- (void)dealloc {
    NSLog(@"Dealloc");
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
