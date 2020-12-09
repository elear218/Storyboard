//
//  CustomBaseViewController.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/8.
//  Copyright © 2020 eall. All rights reserved.
//

#import "CustomBaseViewController.h"
#import "MKBToastView.h"

@interface CustomBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation CustomBaseViewController

+ (instancetype)loadNibVc {
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)setupUI {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    self.isCurrent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isCurrent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self contentInsetAdjustment];
    
    self.view.width = ScreenWidth;
    self.view.height = ScreenHeight;
    [self.view layoutIfNeeded];
    
    _mbp = (MBProgressHUD *)[self.view viewWithTag:99999];
    if (!_mbp) {
        _mbp = [[MBProgressHUD alloc] initWithView:self.view];
//        _mbp.opacity = 0.6f;
        _mbp.bezelView.alpha = 0.6;
        _mbp.tag = 99999;
        [self.view addSubview:_mbp];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRoot) name:@"popToRoot" object:nil];
}

- (void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)toast:(NSString *)text {
    _mbp.mode = MBProgressHUDModeText;
    _mbp.detailsLabel.text = text;
    _mbp.label.text = @"";
    _mbp.margin = 15.f;
    _mbp.detailsLabel.font = kFontSystem(16);
    _mbp.userInteractionEnabled = YES;
    _mbp.minShowTime = 2.0;
    [_mbp removeFromSuperview];
    [[APPDELEGATE window] addSubview:_mbp];
    [[APPDELEGATE window] bringSubviewToFront:_mbp];
    
    [_mbp showAnimated:YES];
    [_mbp hideAnimated:YES afterDelay:1];
}

- (void)toast:(NSString *)text withImg:(UIImage *)image {
    _mbp.mode = MBProgressHUDModeCustomView;
    MKBToastView *toastView = loadNib(@"MKBToastView");
    toastView.imgView.image = image;
    toastView.textLabel.text = text;
    _mbp.customView = toastView;
    
    _mbp.detailsLabel.text = @"";
    _mbp.label.text = @"";
    _mbp.margin = 15.f;

    _mbp.detailsLabel.font = kFontSystem(16);
    _mbp.userInteractionEnabled = YES;
    _mbp.minShowTime = 2.0;
    [_mbp removeFromSuperview];
    [[APPDELEGATE window] addSubview:_mbp];
    [[APPDELEGATE window] bringSubviewToFront:_mbp];

    [_mbp showAnimated:YES];
    [_mbp hideAnimated:YES afterDelay:1];
}

- (void)showLoading:(NSString *)text {
    _mbp.detailsLabel.text = @"";
    _mbp.mode = MBProgressHUDModeIndeterminate;
    if (text) {
        _mbp.label.text = text;
    }else{
        _mbp.label.text = @"";
    }
    _mbp.margin = 20.f;
    _mbp.userInteractionEnabled = YES;
    _mbp.detailsLabel.font = kFontSystem(16);
    _mbp.minShowTime = 0;
    [_mbp removeFromSuperview];
    [self.view addSubview:_mbp];
    [self.view bringSubviewToFront:_mbp];
    
    [_mbp showAnimated:YES];
}

- (void)hideLoading {
    [_mbp hideAnimated:YES afterDelay:0];
}

- (void)initTopBarWithTitle:(NSString *)title {
    [self.titleLabel setText:title];
    [self.topBar addSubview:self.titleLabel];
    
    [self.view addSubview:self.topBar];
    if (self.navigationController.childViewControllers.count > 1) {
        [self addLeftButtonWithImage:kImageNamed(@"back_white")];
    }
}

- (void)initSubtitle:(NSString *)subTitle {
    [self.subTitleLab setText:subTitle];
    [self.topBar addSubview:self.subTitleLab];
}

- (void)addLeftButtonWithImage:(UIImage *)leftButtonImage; {
    [_leftButton removeFromSuperview];
    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(6, isIPhoneX?44:20, 56, 44)];
    if (leftButtonImage) {
        [_leftButton setImage:[leftButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        _leftButton.imageView.tintColor = kBlackColor;
    }
    [_leftButton setTitle:@"" forState:UIControlStateNormal];
    [_leftButton setTitleColor:kColor333333 forState:UIControlStateNormal];
    _leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    [_leftButton addTarget:self action:@selector(leftButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton.titleLabel setFont:kFontSystem(16.f)];
    
    [self.topBar addSubview:_leftButton];
}
- (void)addRightButtonWithImage:(UIImage *)rightButtonImage;
{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-55, isIPhoneX?44:20, 56, 46)];
    if (rightButtonImage) {
        [_rightButton setImage:rightButtonImage forState:UIControlStateNormal];
    }
    [_rightButton.titleLabel setFont:kFontBoldSystem(16)];
    [_rightButton setTitle:@"" forState:UIControlStateNormal];
    
    _rightButton.tag = 2000;
    [_rightButton addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topBar addSubview:_rightButton];
}

- (void)addRightButtonText:(NSString *)rightButtonText {
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-90, isIPhoneX?44:20,100, 44)];
    [_rightButton setTitle:rightButtonText forState:UIControlStateNormal];
    [_rightButton setTitleColor:kColor333333 forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:kFontSystem(16)];
    [_rightButton setImage:kImageNamed(@"") forState:UIControlStateNormal];
    
    _rightButton.tag = 2000;
    [_rightButton addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topBar addSubview:_rightButton];
}

- (void)addRightButton:(UIButton *)button {
    button.frame = CGRectMake(ScreenWidth-90, STATUSBAR_HEIGHT, 100, 44);
    [button addTarget:self action:@selector(rightButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:button];
    
}

// 默认左边按钮为返回功能，若其他功能，子类中重写此段代码
- (void)leftButtonPress {
    WeakSelf(self);
    if (self.navigationController.topViewController == self) {
        dispatch_async(dispatch_get_main_queue(), ^{
            StrongSelf(self);
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            StrongSelf(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (void)rightButtonPress {
    
}

#pragma mark -
#pragma  UI
- (UIView *)topBar {
    if (!_topBar) {
        _topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, isIPhoneX?118:94)];
        _topBar.backgroundColor = kWhiteColor;
//        _topBar.layer.shadowColor = [UIColor hexStringToColor:@"999999" alpha:1.f].CGColor;
//        _topBar.layer.shadowOffset = CGSizeMake(0, 1);//偏移距离
//        _topBar.layer.shadowOpacity = 0.5;//不透明度
//        _topBar.layer.shadowRadius = 1.0;//半径
        
//        CAGradientLayer *graLayer = [CAGradientLayer layer];
//        self.graLayer = graLayer;
//        graLayer.frame = _topBar.bounds;
//
//        UIColor *topColor = kColor55576E;
//        UIColor *bottomColor = kColor55576E;
//
//        graLayer.startPoint = CGPointMake(0, 0);
//        graLayer.endPoint = CGPointMake(0, 1);
//        graLayer.colors = @[(__bridge id)topColor.CGColor,(__bridge id)bottomColor.CGColor];
//        [_topBar.layer addSublayer:graLayer];
//        _topBar.backgroundColor = kLightGrayColor;

    }
    return _topBar;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, isIPhoneX?47:23, ScreenWidth-120, 40)];
//        _titleLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        [_titleLabel setTextColor:kColor333333];
//        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.f, isIPhoneX?88:64, ScreenWidth-30, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:22.f weight:UIFontWeightBold];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setTextColor:kBlackColor];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15.f, isIPhoneX?88:64, ScreenWidth-30, 30)];
        _subTitleLab.font = [UIFont systemFontOfSize:12.f];
        _subTitleLab.backgroundColor = [UIColor clearColor];
        [_subTitleLab setTextColor:kColor999999];
        [_subTitleLab setTextAlignment:NSTextAlignmentRight];
    }
    return _subTitleLab;
}

/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        }else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot {
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
    [self.mbp removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%s",__func__);
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowSelf = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowSelf animated:animated];
}

@end
