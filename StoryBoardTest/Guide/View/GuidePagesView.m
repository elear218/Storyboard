//
//  GuidePagesView.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/11.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "GuidePagesView.h"

@interface GuidePagesView ()<UIScrollViewDelegate>{
    UIImageView *currentImgView;
}

@property (nonatomic, copy) NSArray<NSString *> *imagesArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *jumpBtn;

@property (nonatomic, strong) UIButton *doneBtn;

@end

static CGFloat const doneBtnWidth = 100.f;

@implementation GuidePagesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self addSubview:self.jumpBtn];
}

+ (void)showGuidePageViewWithImages:(NSArray<NSString *> *)imgArr {
    GuidePagesView *pagesView = [[self alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    pagesView.imagesArray = imgArr;
    [[UIApplication sharedApplication].keyWindow addSubview:pagesView];
}

- (void)setImagesArray:(NSArray<NSString *> *)imagesArray {
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((_imagesArray.count + 1) * ScreenWidth, ScreenHeight);
    self.pageControl.numberOfPages = _imagesArray.count;
    
    [_imagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:obj ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:filePath];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
        imageView.tag = 100 + idx;
        imageView.frame = CGRectMake(idx * ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [self.scrollView addSubview:imageView];
        if (idx == 0) {
            currentImgView = imageView;
        }
    }];
    [self.scrollView addSubview:self.doneBtn];
    self.doneBtn.alpha = _imagesArray.count == 1;
    self.jumpBtn.hidden = self.pageControl.hidden = _imagesArray.count == 1;
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_imagesArray.count > 1) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger page = offsetX/ScreenWidth + 0.5;
        self.pageControl.currentPage = page;
        CGFloat criticalWidth = ScreenWidth*(self.imagesArray.count-2); //最后一张图刚出来作为临界点
        if (offsetX >= criticalWidth) {
            CGFloat alpha = (offsetX - criticalWidth)/ScreenWidth*2;
            self.pageControl.alpha = 1 - alpha;
            self.jumpBtn.alpha = 1 - alpha;
            self.doneBtn.alpha = alpha;
        }else {
            self.pageControl.alpha = 1;
            self.jumpBtn.alpha = 1;
            self.doneBtn.alpha = 0;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x >= (_imagesArray.count) * ScreenWidth) {
        [self removeFromSuperview];
    }else {
        NSInteger page = scrollView.contentOffset.x/ScreenWidth;
        currentImgView = [self.scrollView viewWithTag:100+page];
    }
}

#pragma mark 按钮事件
- (void)jumpOrDoneGuide:(UIButton *)sender {
    CGRect frame = currentImgView.frame;
    frame.size = CGSizeMake(ScreenWidth*2.f, ScreenHeight*2.f);
    frame.origin.x -= ScreenWidth/2;
    frame.origin.y -= ScreenHeight/2;
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = .0f;
        self.scrollView.alpha = .0f;
        self.pageControl.alpha = .0f;
        self.jumpBtn.alpha = .0f;
        self.doneBtn.alpha = .0f;
        currentImgView.frame = frame;
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

#pragma mark 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - 60, ScreenWidth, 35)];
        _pageControl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    }
    return _pageControl;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jumpBtn.frame = CGRectMake(ScreenWidth - 80, 25, 60, 30);
        [_jumpBtn addTarget:self action:@selector(jumpOrDoneGuide:) forControlEvents:UIControlEventTouchUpInside];
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
        _doneBtn.frame = CGRectMake(ScreenWidth*_imagesArray.count - ScreenWidth/2 - doneBtnWidth/2, ScreenHeight - 65, doneBtnWidth, 35);
        [_doneBtn addTarget:self action:@selector(jumpOrDoneGuide:) forControlEvents:UIControlEventTouchUpInside];
        _doneBtn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:.8f];
        [_doneBtn setTitle:@"立即进入" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _doneBtn.layer.cornerRadius = 8.f;
//        _doneBtn.alpha = 0;
    }
    return _doneBtn;
}

- (void)dealloc {
    NSLog(@"Dealloc");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
