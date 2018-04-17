//
//  CodePushViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CodePushViewController.h"

#import "UIButton+ImageTitleSpacing.h"

@interface CodePushViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>{
    
    /**顶部试图总容器*/
    UIView *headerContainerView;
    /**自定义导航栏纯色背景*/
    UIView *naviBackgroundView;
    /**搜索框、通讯录、加号*/
    UIView *mainNavView;
    /**扫一扫、付钱、收钱、咻一咻  加号*/
    UIView *coverNavView;
    /**功能区上部分：扫一扫、付钱、收钱、卡包*/
    UIView *funcTopView;
    /**功能区下部分：我的应用*/
    UIView *funcBottomView;
    
    CGFloat customNaviHeight,funcBottomHeight,headerContainerHeight;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString * const cellId = @"UICollectionCellIdentifer";
static NSString * const reuseHeaderId = @"UICollectionReuseHeaderIdentifer";

static CGFloat const funcTopHeight = 85.f; //功能区上部高度(扫一扫、付钱、收钱、卡包)

@implementation CodePushViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.receivedArr enumerateObjectsUsingBlock:^(HobbyModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"item:%@,level:%@,time:%@",obj.item,obj.level,obj.time);
    }];
    
    [self contentInsetAdjustment];
    
    customNaviHeight = [UIApplication sharedApplication].statusBarFrame.size.height + 54;
    funcBottomHeight = 150.f;
    headerContainerHeight = customNaviHeight + funcTopHeight + funcBottomHeight;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = .5f;
    self.collectionView.collectionViewLayout = layout;
    
    WeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh];
        });
    }];
    
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = - headerContainerHeight;
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(headerContainerHeight, 0, 0, 0);
    
    [self setHeaderView];
}

- (void)setHeaderView {
    [self headerContainerView];
    [self mainNavView];
    [self coverNavView];
    [self funcTopView];
    [self funcBottomView];
}

- (void)headerContainerView {
    headerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, headerContainerHeight)];
    headerContainerView.backgroundColor = kHexColor(0x4180FF);
    [self.collectionView addSubview:headerContainerView];
}

- (void)mainNavView {
    mainNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, customNaviHeight)];
    [self.view addSubview:mainNavView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    [mainNavView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0).mas_offset(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(25);
    }];
    
    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactBtn setBackgroundImage:[UIImage imageNamed:@"home_contacts"] forState:UIControlStateNormal];
    [mainNavView addSubview:contactBtn];
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(addBtn);
        make.right.mas_equalTo(addBtn.mas_left).offset(-20);
    }];
    
    UISearchBar *search = [UISearchBar new];
    search.showsBookmarkButton = YES;
    search.backgroundColor = [UIColor whiteColor];
    search.backgroundImage = [UIImage new];
    
    UITextField *textField = [search valueForKey:@"searchField"];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"11111";
    
    [mainNavView addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(addBtn);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(contactBtn.mas_left).offset(-20);
        make.height.mas_equalTo(30);
    }];
}

- (void)coverNavView {
    coverNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, customNaviHeight)];
    coverNavView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
    coverNavView.alpha = 0;
    [self.view addSubview:coverNavView];
    
    naviBackgroundView = [UIView new];
    [coverNavView addSubview:naviBackgroundView];
    [naviBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    NSArray *arr = @[@"home_scan", @"home_pay", @"home_recipient", @"home_xiu"];
    UIButton *lastBtn;
    for (int i = 0; i < arr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        [coverNavView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0).offset(10);
            make.size.mas_equalTo(30);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(35);
            }else
                make.left.mas_equalTo(10);
        }];
        lastBtn = btn;
    }
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"home_add"] forState:UIControlStateNormal];
    [coverNavView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerY.mas_equalTo(lastBtn);
        make.right.mas_equalTo(-10);
    }];
}

- (void)funcTopView {
    funcTopView = [[UIView alloc] initWithFrame:CGRectMake(0, customNaviHeight, ScreenWidth, funcTopHeight)];
    [headerContainerView addSubview:funcTopView];
    
    NSDictionary *funcDic = @{
                                   @"img" :  @[@"home_scan", @"home_pay", @"home_recipient", @"home_card"],
                                   @"txt" :  @[@"扫一扫", @"付钱", @"收钱", @"卡包"]
                                   };
    NSMutableArray *btnArr = [NSMutableArray arrayWithCapacity:[funcDic[@"txt"] count]];
    for (int i = 0; i < [funcDic[@"txt"] count]; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn addTarget:self action:@selector(funcTopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:funcDic[@"img"][i]] forState:UIControlStateNormal];
        [btn setTitle:funcDic[@"txt"][i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.5f];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [funcTopView addSubview:btn];
        [btnArr addObject:btn];
    }
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:15 tailSpacing:15];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(-5);
    }];
    
    [btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
    }];
}

- (void)funcBottomView {
    funcBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(funcTopView.frame), ScreenWidth, funcBottomHeight)];
    [headerContainerView addSubview:funcBottomView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = .0f;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    [funcBottomView addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)endRefresh {
    [self.collectionView.mj_header endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc");
}


- (void)updateContentOffset {
    CGFloat offsetY = self.collectionView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= funcTopHeight) {
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:.3f animations:^{
//            [self.collectionView setContentOffset:CGPointMake(0, offsetY >= funcTopHeight / 2 ?funcTopHeight : .0f) animated:YES];
            [self.collectionView setContentOffset:CGPointMake(0, offsetY >= funcTopHeight / 2 ?funcTopHeight : .0f)];
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
    }
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        headerContainerView.frame = CGRectMake(0, offsetY >= 0 ? 0 : offsetY, ScreenWidth, headerContainerHeight);
        
        //功能区滑动视差
        if (offsetY <= 0) {
            //功能区状态回归
            CGRect frame = funcTopView.frame;
            frame.origin.y = customNaviHeight;
            funcTopView.frame = frame;
        }else if (offsetY > 0 && offsetY < funcTopHeight) {
            //处理功能区视差
            CGRect frame = funcTopView.frame;
            frame.origin.y = customNaviHeight + offsetY/2;
            funcTopView.frame = frame;
        }
        
        CGFloat alpha = (1 - offsetY/funcTopHeight) ? : 0;
        
        funcTopView.alpha = alpha;
        if (alpha > .5f) {
            mainNavView.alpha = alpha * 2 - 1;
            coverNavView.alpha = 0;
        }else {
            mainNavView.alpha = 0;
            funcTopView.alpha = alpha * .25f;
            coverNavView.alpha = 1 - alpha * 2;
        }
        
        if (alpha > 0) {
            naviBackgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
        }else
            naviBackgroundView.backgroundColor = kHexColor(0x4180FF);
    }
}

/**
 结束拖动
 
 @param scrollView 滚动试图
 @param decelerate 该值为YES的时候表示scrollview在停止拖动之后还会向前滑动一段距离，并且在结束之后调用     scrollViewDidEndDecelerating方法
 该值为NO的时候表示scrollview在停止拖拽之后立即停止滑动
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate && scrollView == self.collectionView) {
        [self updateContentOffset];
        NSLog(@"11111");
    }
}

/**
 减速停止
 
 @param scrollView 滚动视图
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        [self updateContentOffset];
        NSLog(@"22222");
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    UILabel *label = [cell viewWithTag:666];
    label.text = [NSString stringWithFormat:@"第%ld个",indexPath.item + 1];
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth / 3 - 1, 150);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:reuseHeaderId
                                                                                   forIndexPath:indexPath];
    return headView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(1, headerContainerHeight);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
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
