//
//  CodePushViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "CodePushViewController.h"
#import "EditItemViewController.h"

#import "UIButton+ImageTitleSpacing.h"

#import "AlipayItemModel.h"

@interface CodePushViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UISearchBarDelegate>{
    
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

@property (nonatomic, strong) NSMutableArray *itemDataArr;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *itemCellId = @"AliPayFunctionItemCellIdentifer";

static NSString * const cellId = @"UICollectionCellIdentifer";
static NSString * const reuseHeaderId = @"UICollectionReuseHeaderIdentifer";

static CGFloat const funcTopHeight = 85.f; //功能区上部高度(扫一扫、付钱、收钱、卡包)

static CGFloat const itemCellHeight = 80.f; //功能区底部每个item的高度

@implementation CodePushViewController

- (NSMutableArray *)itemDataArr {
    if (!_itemDataArr) {
        _itemDataArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _itemDataArr;
}

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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = .5f;
    layout.itemSize = CGSizeMake(ScreenWidth / 3 - 1, 100);
    self.collectionView.collectionViewLayout = layout;
    
    WeakSelf(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh];
        });
    }];
    
    customNaviHeight = [UIApplication sharedApplication].statusBarFrame.size.height + 54;
    funcBottomHeight = (self.itemDataArr.count + 3) / 4 * itemCellHeight;
    headerContainerHeight = customNaviHeight + funcTopHeight + funcBottomHeight;
    
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = - headerContainerHeight;
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(headerContainerHeight, 0, 0, 0);
    
    [self setHeaderView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AlipayItem" ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化
        NSError *err;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (!err) {
            NSArray *dataArr = [NSArray yy_modelArrayWithClass:[AlipayItemModel class] json:json];
            [self.itemDataArr addObjectsFromArray:[dataArr subarrayWithRange:NSMakeRange(0, 9)]];
            [self.itemDataArr addObject:[dataArr lastObject]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateTopViewHeight];
        });
    });
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
    search.delegate = self;
    search.showsBookmarkButton = YES;
    [search setImage:[UIImage imageNamed:@"search_voice"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    search.barTintColor = [UIColor whiteColor];
//    search.backgroundColor = [UIColor whiteColor];
//    search.backgroundImage = [UIImage new];
    
    UITextField *textField = [search valueForKey:@"searchField"];
    textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.0f];
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
    layout.itemSize = CGSizeMake(ScreenWidth/4, itemCellHeight);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.tag = 111;
    collection.backgroundColor = [UIColor whiteColor];
    [funcBottomView addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [collection registerNib:[UINib nibWithNibName:@"AliPayFunctionItemCell" bundle:nil] forCellWithReuseIdentifier:itemCellId];
    collection.delegate = self;
    collection.dataSource = self;
    
    //添加长安手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    longPress.minimumPressDuration = .5f;
    [collection addGestureRecognizer:longPress];
}

-(void)longPressMethod:(UILongPressGestureRecognizer*)gesture {
    UICollectionView *collection = (UICollectionView *)gesture.view;
    CGPoint location = [gesture locationInView:collection];
    NSIndexPath *indexPath = [collection indexPathForItemAtPoint:location];
    if (indexPath && indexPath.item != self.itemDataArr.count - 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"想调整首页应用？去“更多”进行编辑吧" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去编辑" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:@"gotoEditItemIdentifer" sender:nil];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
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


- (void)updateTopViewHeight {
    funcBottomHeight = (self.itemDataArr.count + 3) / 4 * itemCellHeight;
    headerContainerHeight = customNaviHeight + funcTopHeight + funcBottomHeight;
    
    CGRect containerViewframe = headerContainerView.frame;
    containerViewframe.size.height = headerContainerHeight;
    headerContainerView.frame = containerViewframe;
    
    CGRect funcBottomFrame = funcBottomView.frame;
    funcBottomFrame.size.height = funcBottomHeight;
    funcBottomView.frame = funcBottomFrame;
    
    UICollectionView *collection = [funcBottomView viewWithTag:111];
    [collection reloadData];
    [self.collectionView reloadData];
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(headerContainerHeight, 0, 0, 0);
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = - headerContainerHeight;
    [self.collectionView.mj_header placeSubviews];
}

- (void)updateContentOffset {
    CGFloat offsetY = self.collectionView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= funcTopHeight) {
        self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:.3f animations:^{
//            [self.collectionView setContentOffset:CGPointMake(0, offsetY >= funcTopHeight / 2 ?funcTopHeight : .0f) animated:YES];
            [self.collectionView setContentOffset:CGPointMake(0, offsetY >= funcTopHeight / 2 ? funcTopHeight : .0f)];
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled = YES;
        }];
    }
}

#pragma mark <UISearchBarDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"SeachBarClick");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"搜索框被点击" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    return NO;
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"VoiceClick");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"话筒被点击" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
        
        funcTopView.alpha = (1 - offsetY/funcTopHeight*1.5) ? : 0;;
        if (alpha > .5f) {
            mainNavView.alpha = alpha * 2 - 1;
            coverNavView.alpha = 0;
        }else {
            mainNavView.alpha = 0;
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
    }
}

/**
 减速停止
 
 @param scrollView 滚动视图
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        [self updateContentOffset];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView == self.collectionView ? 16 : self.itemDataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        //    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        UILabel *label = [cell viewWithTag:666];
        label.text = [NSString stringWithFormat:@"第%ld个",indexPath.item + 1];
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCellId forIndexPath:indexPath];
    AlipayItemModel *model = self.itemDataArr[indexPath.item];
    UIImageView *imageView = [cell viewWithTag:665];
    imageView.image = [UIImage imageNamed:model.img];
    UILabel *label = [cell viewWithTag:666];
    label.text = model.txt;
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:reuseHeaderId
                                                                                       forIndexPath:indexPath];
        return headView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return collectionView == self.collectionView ? CGSizeMake(1, headerContainerHeight) : CGSizeZero;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIView *bgView = [cell viewWithTag:111];
    bgView.alpha = .6f;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            UIView *bgView = [cell viewWithTag:111];
            bgView.alpha = 1.f;
    });
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (collectionView != self.collectionView && indexPath.item == self.itemDataArr.count - 1) {
        //点击功能区更多
        [self performSegueWithIdentifier:@"gotoEditItemIdentifer" sender:nil];
        return;
    }
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:666];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = label.text;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"gotoEditItemIdentifer"]) {
        EditItemViewController *vc = segue.destinationViewController;
        vc.changeBlock = ^(NSArray *itemArr) {
            [self.itemDataArr removeAllObjects];
            [self.itemDataArr addObjectsFromArray:itemArr];
            [self updateTopViewHeight];
        };
    }
}


@end
