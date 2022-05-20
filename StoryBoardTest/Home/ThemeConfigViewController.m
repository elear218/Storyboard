//
//  ThemeConfigViewController.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/10.
//  Copyright © 2020 eall. All rights reserved.
//

#import "ThemeConfigViewController.h"

@interface ThemeConfigViewController ()

@property (nonatomic, assign) ThemeColorType themeType;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *tipLabArr;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgViewArr;

@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunBtn;
@property (weak, nonatomic) IBOutlet UIButton *toggleBtn;

@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@end

@implementation ThemeConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.bottomBtn shadow:[UIColor blackColor] opacity:.2f radius:5.f offset:CGSizeMake(3.f, 3.f)];
    
    self.themeType = [ThemeConfig getThemeColorType];
    [self reloadThemeViews];
    
    NSLog(@"testArr:%@", self.testArr);
}

- (void)reloadThemeViews {
    UIColor *themeColor = [ThemeConfig getThemeColorWithType:self.themeType];
    [self.tipLabArr enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.textColor = themeColor;
    }];
    [self.imgViewArr enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imageName = @[@"icon_rain", @"icon_temp"][idx];
        obj.image = kThemeImageByName(imageName);
    }];
    [self.locationBtn setImage:kThemeImageByName(@"icon_location") forState:UIControlStateNormal];
    [self.locationBtn setImage:kThemeImageByName(@"icon_location") forState:UIControlStateHighlighted];
    [self.locationBtn setTitleColor:themeColor forState:UIControlStateNormal];
    
    [self.sunBtn setImage:[kThemeImageByName(@"forecast_sun") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.sunBtn setTitleColor:themeColor forState:UIControlStateNormal];
    [self.sunBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:5.f];
    
    [self refreshToggleBtn];
//    [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_0") forState:UIControlStateNormal];
//    [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_1") forState:UIControlStateSelected];
//    if (self.toggleBtn.selected) {
//        [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_1") forState:UIControlStateSelected|UIControlStateHighlighted];
//    }else
//        [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_0") forState:UIControlStateHighlighted];
    
    [self.toggleBtn setTitleColor:themeColor forState:UIControlStateNormal];
    
    self.bottomBtn.backgroundColor = themeColor;
    
//    [self.navigationController.navigationBar setBarTintColor:themeColor];
//    //导航条前景色
//    [[UINavigationBar appearance] setBarTintColor:themeColor];
    //导航条前景色
    if (@available(iOS 15.0, *)) {
//        [UINavigationBar appearance].scrollEdgeAppearance.backgroundColor = themeColor;
//        [UINavigationBar appearance].standardAppearance.backgroundColor = themeColor;
        self.navigationController.navigationBar.scrollEdgeAppearance.backgroundColor = themeColor;
        self.navigationController.navigationBar.standardAppearance.backgroundColor = themeColor;
    }else {
        [[UINavigationBar appearance] setBarTintColor:themeColor];
    }
}

- (IBAction)topThemeBtnClick:(UIButton *)sender {
    if (sender.tag + ThemeColorTypeSpring == self.themeType) {
        return;
    }
    self.themeType = sender.tag + ThemeColorTypeSpring;
    [ThemeConfig storeThemeColorType:self.themeType];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNameThemeChange object:nil];
    [self reloadThemeViews];
    !self.themeChangeBlock ? : self.themeChangeBlock();
}

- (IBAction)toggleBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self refreshToggleBtn];
}

- (void)refreshToggleBtn {
    [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_0") forState:UIControlStateNormal];
    [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_1") forState:UIControlStateSelected];
    
    //1.问题：改变按钮状态，发现从selected切回到normal状态时候，中间会切换normal-selected-normal的图片
    //2.原因：normal-->selected  会经过highlighted（高亮）状态，默认是normal下加了一层灰蒙版
    //       selected-->normal  会经过selected（选中）| highlighted（高亮）状态
    if (self.toggleBtn.selected) {
        [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_1") forState:UIControlStateSelected | UIControlStateHighlighted];
    }else
        [self.toggleBtn setImage:kThemeImageByName(@"forecast_toggle_0") forState:UIControlStateHighlighted];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
