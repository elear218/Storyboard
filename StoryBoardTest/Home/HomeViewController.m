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

#import "ThemeConfigViewController.h"

@interface HomeViewController (){
    __weak IBOutlet CustomXibView *view1;
}

@property (weak, nonatomic) IBOutlet UIButton *themeBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat navigationHeight = [UIApplication sharedApplication].statusBarFrame.size.height + 44;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    NSLog(@"navigationHeight:%f\ntabBarHeight:%f", navigationHeight, tabBarHeight);
    
    view1.block = ^{
        [self performSegueWithIdentifier:@"gotoCycleVCIdentifer" sender:nil];
    };
    
    CustomXibView *view = [[CustomXibView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    view.block = ^{
        [self performSegueWithIdentifier:@"gotoCycleVCIdentifer" sender:nil];
    };
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 230));
    }];
    
    NSString *contentStr = @"模糊匹配:\n1、XXXX高铁霸座XXX2、高铁提速了3、座位4、霸王项羽XXXX5、冰封王座XXXX铁XXXX";
    view.contentLab.attributedText = [self matchingContentAnyKey:contentStr keyWord:@"高铁霸座" font:nil contentColor:nil keyWordColor:nil];
    
    YYFPSLabel *fpsLab = [YYFPSLabel new];
    [[UIApplication sharedApplication].keyWindow addSubview:fpsLab];
    [fpsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
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
    [self.themeBtn setImage:kThemeImageByName(@"theme_set") forState:UIControlStateNormal];
    [self.themeBtn setTitleColor:[ThemeConfig themeColor] forState:UIControlStateNormal];
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

/**
 在文本内容中 匹配任一字符

 @param content 文本
 @param keyWord 关键字
 @param font 文本字体大小
 @param contentColor 文本颜色
 @param keyWordColor 关键字颜色
 @return NSMutableAttributedString
 */
-  (NSMutableAttributedString *)matchingContentAnyKey:(NSString *)content
                                              keyWord:(NSString *)keyWord
                                                 font:(UIFont *)font
                                         contentColor:(UIColor *)contentColor
                                         keyWordColor:(UIColor *)keyWordColor {
    if (content == nil || ![content isKindOfClass:[NSString class]]) {
        content = @"";
    }
    
    if (font == nil) {
        font = [UIFont systemFontOfSize:16];
    }
    
    if (contentColor == nil) {
        contentColor = [UIColor blackColor];
    }
    
    if (keyWordColor == nil) {
        keyWordColor = [UIColor redColor];
    }
    
    //属性文本
    NSMutableAttributedString *attributeContent;
    {
        NSMutableParagraphStyle *ps = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [ps setLineBreakMode:NSLineBreakByTruncatingTail];
        NSDictionary *attrDict = @{NSFontAttributeName: font, NSForegroundColorAttributeName:contentColor, NSParagraphStyleAttributeName:ps};
        
        attributeContent = [[NSMutableAttributedString alloc] initWithString:content
                                                                  attributes:attrDict];
    }
    
    
    NSString *regEmj  = [NSString stringWithFormat:@"[.%@]",keyWord];
    NSError *error    = nil;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regEmj
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    if (!expression) {
        return attributeContent;
    }
    
    NSArray *resultArray = [expression matchesInString:content
                                               options:0
                                                 range:NSMakeRange(0, content.length)];
    NSDictionary *tmpDict = @{NSFontAttributeName : font, NSForegroundColorAttributeName : keyWordColor};
    for (NSTextCheckingResult *match in resultArray) {
        NSRange range    = match.range;
        [attributeContent setAttributes:tmpDict range:range];
    }
    
    return attributeContent;
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
    if ([segue.identifier isEqualToString:@"gotoThemeConfig"]) {
        ThemeConfigViewController *themeVC = segue.destinationViewController;
        themeVC.testArr = @[@1, @2, @3, @4, @5];
        WeakSelf(self);
        themeVC.themeChangeBlock = ^{
            StrongSelf(self);
            [self.themeBtn setImage:kThemeImageByName(@"theme_set") forState:UIControlStateNormal];
            [self.themeBtn setTitleColor:[ThemeConfig themeColor] forState:UIControlStateNormal];
        };
        return;
    }
}

@end
