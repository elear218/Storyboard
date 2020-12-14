//
//  CustomBaseViewController.h
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomBaseViewController : UIViewController

@property (nonatomic,strong) MBProgressHUD *mbp;
@property (nonatomic,strong) UIView *topBar;
@property (nonatomic,strong) UIButton *leftButton, *rightButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (strong,nonatomic) UIView *statusBarView;
@property (nonatomic, assign) BOOL isCurrent;

//初始化导航条
- (void)initTopBarWithTitle:(NSString *)title;
//设置右侧子标题
- (void)initSubtitle:(NSString *)subTitle;
//设置导航条左右按钮
- (void)addLeftButtonWithImage:(UIImage *)leftButtonImage;
- (void)addRightButtonWithImage:(UIImage *)rightButtonImage;
- (void)addRightButtonText:(NSString *)rightButtonText;
- (void)addRightButton:(UIButton *)button;
- (void)setupUI;
//点击左侧返回 子类可重写
- (void)leftButtonPress;
- (void)rightButtonPress;
//弹出指示器
- (void)toast:(NSString *)text;
- (void)toast:(NSString *)text withImg:(UIImage *)image;
//加载
- (void)showLoading:(NSString *)text;
//隐藏指示器
- (void)hideLoading;
//截取当前屏幕
- (UIImage *)imageWithScreenshot;

+ (instancetype)loadNibVc;

@end

NS_ASSUME_NONNULL_END
