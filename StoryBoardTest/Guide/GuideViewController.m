//
//  GuideViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/11.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "GuideViewController.h"

#import <TAPageControl.h>

@interface GuideViewController ()<UIScrollViewDelegate>{
//    CGFloat
    NSArray *_imagesArray;
    BOOL shouldHide;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TAPageControl *pageControl;

@property (nonatomic, strong) UIButton *jumpBtn;

@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation GuideViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (TAPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[TAPageControl alloc] init];
        _pageControl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
        _pageControl.numberOfPages = _imagesArray.count;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.dotSize = CGSizeMake(13, 13);
        _pageControl.dotImage = [UIImage imageNamed:@"time_normal"];
        _pageControl.currentDotImage = [UIImage imageNamed:@"time_seleted"];
    }
    return _pageControl;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpBtn addTarget:self action:@selector(jumpGuide:) forControlEvents:UIControlEventTouchUpInside];
        _jumpBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.5f];
        [_jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_jumpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:13.5f];
        _jumpBtn.layer.cornerRadius = 5.f;
    }
    return _jumpBtn;
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn addTarget:self action:@selector(nextOrDoneGuide:) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:.8f];
        [_doneBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _doneBtn.layer.cornerRadius = 8.f;
    }
    return _doneBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //禁用侧滑返回
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    [self contentInsetAdjustment];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
//    _imagesArray = @[@"Guide1", @"Guide2", @"Guide3", @"Guide4"];
    _imagesArray = @[@"Guide1"];
    
    UIView *containerView = [UIView new];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.height.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(ScreenWidth*_imagesArray.count);
    }];
    
    NSMutableArray *imgViewArr = [NSMutableArray arrayWithCapacity:_imagesArray.count];
    [_imagesArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:obj ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
//        imageView.tag = 100 + idx;
        [containerView addSubview:imageView];
        [imgViewArr addObject:imageView];
    }];
    
    if (imgViewArr.count > 1) {
        [imgViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:ScreenWidth leadSpacing:0 tailSpacing:0];
        [imgViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
        }];
    }else {
        [imgViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self.doneBtn setTitle:@"立即进入" forState:UIControlStateNormal];
        self.jumpBtn.hidden = YES;
    }
    
    [self.view addSubview:self.jumpBtn];
    [self.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    [self.view addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.pageControl.mas_top).offset(-15);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    // Do any additional setup after loading the view.
    [ELBaseService postOperationWithUrl:@"base/api/v1/supplier/getByCode" params:@{@"supplierCode" : @"300089"} handler:^(BOOL success, id  _Nonnull response, NSString * _Nonnull errorMsg) {
        
    }];
    
    [ELBaseService postOperationWithUrl:@"base/api/v3/shop/getAllListForSupplierUser" params:@{@"retailEnable" : @0, @"shopStatus" : @YES, @"needDinnerTypeEnable" : @YES} handler:^(BOOL success, id  _Nonnull response, NSString * _Nonnull errorMsg) {
        if (success) {
            
        }else {
            
        }
    }];
}

#pragma mark 按钮事件
- (void)jumpGuide:(UIButton *)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 1.f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)nextOrDoneGuide:(UIButton *)sender {
    if (self.pageControl.currentPage == _imagesArray.count - 1) {
        ELogInfo(@"111", @"faddsd");
        ELogError(@"1111", @"test");
        ELog(@"123456");
        ELogD(@"sfaewew");
        ELogDebug(@"123", @"elogTest");
//        [[ELLogManager sharedInstance] writeFile];
        //模拟应用崩溃
//        NSArray *arr = @[@"1", @"2"];
//        NSString *str = arr[2];
        [self jumpGuide:nil];
    }else {
        NSInteger page = self.pageControl.currentPage;
        page++;
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth*page, 0) animated:YES];
    }
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_imagesArray.count > 1) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger page = offsetX/ScreenWidth + 0.5;
        self.pageControl.currentPage = page;
        CGFloat criticalWidth = ScreenWidth*(_imagesArray.count-2); //最后一张图刚出来作为临界点
        if (offsetX >= criticalWidth) {
            CGFloat alpha = (offsetX - criticalWidth)/ScreenWidth*2;
            self.jumpBtn.alpha = 1 - alpha;
            [self.doneBtn setTitle:(offsetX-criticalWidth>=ScreenWidth/2)?@"立即进入":@"下一步" forState:UIControlStateNormal];
        }else {
            self.jumpBtn.alpha = 1;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    shouldHide = scrollView.contentOffset.x >= (_imagesArray.count - 1) * ScreenWidth;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == (_imagesArray.count - 1) * ScreenWidth && shouldHide) {
        [self jumpGuide:nil];
    }
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
