//
//  MKBNewFunctionController.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/16.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "MKBNewFunctionController.h"
#import "MKBFunctionHeader.h"
#import "MKBFunctionSectionHeader.h"
#import "MKBFunctionSectionFooter.h"

#import "FunctionStoreTool.h"

@interface MKBNewFunctionController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTop;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<MKBFunctionModel *> *commonFuncArr;
@property (nonatomic, strong) NSMutableArray<MKBFunctionModel *> *userFuncArr;
@property (nonatomic, strong) NSMutableArray<MKBFunctionModel *> *managerFuncArr;
@property (nonatomic, strong) NSMutableArray<MKBFunctionModel *> *serviceFuncArr;

@property (nonatomic, assign) BOOL isFirstNormal;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) MKBFunctionCell *dragingItem;

@property (nonatomic, strong) NSIndexPath *dragingIndexPath;

@property (nonatomic, strong) NSIndexPath *targetIndexPath;

@property (nonatomic, assign) BOOL isDraging;

@end

@implementation MKBNewFunctionController

- (NSMutableArray<MKBFunctionModel *> *)commonFuncArr {
    if (!_commonFuncArr) {
        _commonFuncArr = [NSMutableArray array];
    }
    return _commonFuncArr;;
}

- (NSMutableArray<MKBFunctionModel *> *)userFuncArr {
    if (!_userFuncArr) {
        _userFuncArr = [NSMutableArray array];
    }
    return _userFuncArr;;
}

- (NSMutableArray<MKBFunctionModel *> *)managerFuncArr {
    if (!_managerFuncArr) {
        _managerFuncArr = [NSMutableArray array];
    }
    return _managerFuncArr;;
}

- (NSMutableArray<MKBFunctionModel *> *)serviceFuncArr {
    if (!_serviceFuncArr) {
        _serviceFuncArr = [NSMutableArray array];
    }
    return _serviceFuncArr;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTopBarWithTitle:@"功能"];
    
    if (@available(iOS 11.0, *)){
        
    }else {
        self.viewTop.constant = 94;
    }
    [self addRightButtonText:@"完成"];
    
    self.isFirstNormal = YES;
    [self dealData];
    [self setupUI];
}

- (void)dealData {
    NSArray *allFuncTypeArray = [FunctionStoreTool commonFuncTypeArray];
    if (self.isEdit) {
        NSMutableArray *localFuncArr = [NSMutableArray arrayWithCapacity:self.commonFuncArr.count];
        [self.commonFuncArr enumerateObjectsUsingBlock:^(MKBFunctionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [localFuncArr addObject:@(obj.tag)];
        }];
        allFuncTypeArray = localFuncArr;
    }
    NSInteger count = MIN(7, allFuncTypeArray.count);
    if (!self.isEdit) {
        [self.commonFuncArr removeAllObjects];
        for (int i = 0; i < count; i++) {
            MKBFunctionModel *func = [MKBFunctionModel new];
            func.tag = [allFuncTypeArray[i] integerValue];
            [self.commonFuncArr addObject:func];
        }
    }
    
    NSArray *userFuncArr = [FunctionStoreTool userFuncTypeArray];
    NSArray *managerFuncArr = [FunctionStoreTool managerFuncTypeArray];
    NSArray *serviceFuncArr = [FunctionStoreTool serviceFuncTypeArray];
    [self.userFuncArr removeAllObjects];
    [self.managerFuncArr removeAllObjects];
    [self.serviceFuncArr removeAllObjects];
    NSMutableArray *userDealedFuncArr = [NSMutableArray arrayWithArray:userFuncArr];
    NSMutableArray *managerDealedFuncArr = [NSMutableArray arrayWithArray:managerFuncArr];
    NSMutableArray *serviceDealedFuncArr = [NSMutableArray arrayWithArray:serviceFuncArr];
    
    if (self.isEdit) {
        NSArray *arr = [allFuncTypeArray subarrayWithRange:NSMakeRange(0, count)];
        [userDealedFuncArr removeObjectsInArray:arr];
        [managerDealedFuncArr removeObjectsInArray:arr];
        [serviceDealedFuncArr removeObjectsInArray:arr];
    }
    for (int i = 0; i < userDealedFuncArr.count; i++) {
        MKBFunctionModel *func = [MKBFunctionModel new];
        func.tag = [userDealedFuncArr[i] integerValue];
        [self.userFuncArr addObject:func];
    }
    for (int i = 0; i < managerDealedFuncArr.count; i++) {
        MKBFunctionModel *func = [MKBFunctionModel new];
        func.tag = [managerDealedFuncArr[i] integerValue];
        [self.managerFuncArr addObject:func];
    }
    for (int i = 0; i < serviceDealedFuncArr.count; i++) {
        MKBFunctionModel *func = [MKBFunctionModel new];
        func.tag = [serviceDealedFuncArr[i] integerValue];
        [self.serviceFuncArr addObject:func];
    }
}

- (void)setupUI {
    [self setupNormalHeader];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MKBFunctionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MKBFunctionSectionHeader class])];
    [self.collectionView registerClass:[MKBFunctionSectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([MKBFunctionSectionFooter class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MKBFunctionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MKBFunctionCell class])];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    gesture.minimumPressDuration = .5f;
    [self.collectionView addGestureRecognizer:gesture];
    
    self.dragingItem = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MKBFunctionCell class]) owner:self options:nil].firstObject;
    self.dragingItem.size = CGSizeMake((ScreenWidth - 25) / 4.f, 100.f);
    self.dragingItem.backgroundColor = [kWhiteColor colorWithAlphaComponent:.5f];
    self.dragingItem.hidden = YES;
    [self.collectionView addSubview:self.dragingItem];
}

- (void)setupNormalHeader {
    self.titleLabel.text = @"功能";
    [self addRightButtonWithImage:kImageNamed(@"")];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    [self.leftButton setImage:[kImageNamed(@"back_white") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.leftButton.imageView.tintColor = kBlackColor;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //这里对添加到右滑视图上的所有手势禁用
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = YES;
        }
    }
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MKBFunctionHeader class]]) {
            [obj removeFromSuperview];
        }
    }];
    CGFloat height = 56.f + (self.isFirstNormal ? (isIPhoneX ? 78.f : 20.f) : .0f);
    self.collectionView.contentInset = UIEdgeInsetsMake(56.f, 0, 0, 0);
    MKBFunctionHeader *header = loadNib(@"MKBFunctionHeader");
    header.frame = CGRectMake(0, -56.f, ScreenWidth, height);
    [self.collectionView addSubview:header];
    WeakSelf(self);
    header.editBlock = ^{
        StrongSelf(self);
        self.isEdit = YES;
        [self dealData];
        [self setupEditUI];
    };
    header.commonFuncArr = self.commonFuncArr;
    self.isFirstNormal = NO;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(0, -height) animated:NO];
}

- (void)setupEditUI {
    self.titleLabel.text = @"常用功能编辑";
    [self addRightButtonText:@"完成"];
    [self addLeftButtonWithImage:nil];
    [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:kColor333333 forState:UIControlStateNormal];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //这里对添加到右滑视图上的所有手势禁用
        for (UIGestureRecognizer *popGesture in self.navigationController.interactivePopGestureRecognizer.view.gestureRecognizers) {
            popGesture.enabled = NO;
        }
    }
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MKBFunctionHeader class]]) {
            [obj removeFromSuperview];
        }
    }];
    self.collectionView.contentInset = UIEdgeInsetsZero;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero animated:NO];
}

- (void)leftButtonPress {
    self.collectionView.userInteractionEnabled = YES;
    if (self.isEdit) {
        self.isEdit = NO;
        [self dealData];
        [self setupNormalHeader];
    }else
        [super leftButtonPress];
}

- (void)rightButtonPress {
    if (!self.isEdit) {
        return;
    }
    self.collectionView.userInteractionEnabled = YES;
    NSMutableArray *localFuncArr = [NSMutableArray arrayWithCapacity:self.commonFuncArr.count];
    [self.commonFuncArr enumerateObjectsUsingBlock:^(MKBFunctionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [localFuncArr addObject:@(obj.tag)];
    }];
    [FunctionStoreTool storeCommonFuncTypeArray:localFuncArr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isEdit = NO;
        [self dealData];
        [self setupNormalHeader];
        !self.updateBlock ? : self.updateBlock();
    });
}

#pragma mark -- CollectionView代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.isEdit ? CGSizeMake(ScreenWidth, 35.f) : CGSizeZero;
        case 1:
            return self.userFuncArr.count ? CGSizeMake(ScreenWidth, 35.f) : CGSizeZero;
        case 2:
            return self.managerFuncArr.count ? CGSizeMake(ScreenWidth, 35.f) : CGSizeZero;
        case 3:
            return self.serviceFuncArr.count ? CGSizeMake(ScreenWidth, 35.f) : CGSizeZero;
        default:
            return CGSizeZero;;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        MKBFunctionSectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MKBFunctionSectionHeader class]) forIndexPath:indexPath];
        header.backgroundColor = kClearColor;
        header.titleStr = @[@"常用功能", @"后勤功能", @"后勤管理", @"后勤服务"][indexPath.section];
        header.detailStr = !indexPath.section ? @"（按住拖拽调整顺序）" : @"";
        reusableView = header;
    }else if (kind == UICollectionElementKindSectionFooter) {
        MKBFunctionSectionFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([MKBFunctionSectionFooter class]) forIndexPath:indexPath];
        footer.backgroundColor = kClearColor;
        reusableView = footer;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return self.isEdit && !section ? CGSizeMake(ScreenWidth, 45.f) : CGSizeZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.isEdit ? self.commonFuncArr.count : 0;
        case 1:
            return self.userFuncArr.count;
        case 2:
            return self.managerFuncArr.count;
        case 3:
            return self.serviceFuncArr.count;
        default:
            return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth - 25) / 4.f, 100.f);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MKBFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MKBFunctionCell class]) forIndexPath:indexPath];
    cell.backgroundColor = kClearColor;
    if (!indexPath.section) {
        cell.operateType = 1 == self.commonFuncArr.count ? 0 : 2;
        cell.func = self.commonFuncArr[indexPath.item];
    }else {
        cell.operateType = self.isEdit && self.commonFuncArr.count < 7 ? 1 : 0;
        NSArray *arr;
        switch (indexPath.section) {
            case 1:
                arr = self.userFuncArr;
                break;
            case 2:
                arr = self.managerFuncArr;
                break;
            case 3:
                arr = self.serviceFuncArr;
                break;
            default:
                break;
        }
        cell.func = arr[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEdit) {
        if (self.isDraging) return;
        MKBFunctionCell *cell = (MKBFunctionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        if (!indexPath.section) {
            if (1 == self.commonFuncArr.count)  return;
            self.collectionView.userInteractionEnabled = NO;
            MKBFunctionModel *func = self.commonFuncArr[indexPath.item];
            [self.commonFuncArr removeObjectAtIndex:indexPath.item];
            [self dealData];
            __block NSIndexPath *targetIndexPath;
            if (func.isManage) {
                [self.managerFuncArr enumerateObjectsUsingBlock:^(MKBFunctionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == func.tag) {
                        targetIndexPath = [NSIndexPath indexPathForItem:idx inSection:2];
                        *stop = YES;
                    }
                }];
            }else if (func.isService) {
                [self.serviceFuncArr enumerateObjectsUsingBlock:^(MKBFunctionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == func.tag) {
                        targetIndexPath = [NSIndexPath indexPathForItem:idx inSection:3];
                        *stop = YES;
                    }
                }];
            }else {
                [self.userFuncArr enumerateObjectsUsingBlock:^(MKBFunctionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.tag == func.tag) {
                        targetIndexPath = [NSIndexPath indexPathForItem:idx inSection:1];
                        *stop = YES;
                    }
                }];
            }
            if (targetIndexPath) {
                cell.operateType = 1;
                [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPath];
            }else {
                [self.collectionView reloadData];
            }
        }else {
            if (7 <= self.commonFuncArr.count)  return;
            NSArray *arr;
            switch (indexPath.section) {
                case 0:
                    arr = self.commonFuncArr;
                    break;
                case 1:
                    arr = self.userFuncArr;
                    break;
                case 2:
                    arr = self.managerFuncArr;
                    break;
                case 3:
                    arr = self.serviceFuncArr;
                    break;
                default:
                    break;
            }
            self.collectionView.userInteractionEnabled = NO;
            [self.commonFuncArr addObject:arr[indexPath.item]];
            [self dealData];
            cell.operateType = 2;
            [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.commonFuncArr.count - 1 inSection:0]];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.35f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.collectionView.userInteractionEnabled = YES;
            [self.collectionView reloadData];
        });
//        [self dealData];
//        [self.collectionView reloadData];
        return;
    }
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = [cell viewWithTag:666];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = label.text;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    /*
    NSArray *arr;
    switch (indexPath.section) {
        case 0:
            arr = self.commonFuncArr;
            break;
        case 1:
            arr = self.userFuncArr;
            break;
        case 2:
            arr = self.managerFuncArr;
            break;
        case 3:
            arr = self.serviceFuncArr;
            break;
        default:
            break;
    }
    
    MKBFunctionModel *func = arr[indexPath.item];
    [self itemClickResponse:func];
    */
}

#pragma mark -- 拖动排序
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return !indexPath.section ? YES : NO;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture {
    if (!self.isEdit) {
        return;
    }
    CGPoint point = [gesture locationInView:self.collectionView];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd];
            break;
        default:
            break;
    }
}

//拖拽开始 找到被拖拽的item
- (void)dragBegin:(CGPoint)point {
    self.dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!self.dragingIndexPath) {return;}
    self.isDraging = YES;
    [self.collectionView bringSubviewToFront:self.dragingItem];
    MKBFunctionCell *item = (MKBFunctionCell *)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
    item.isMoving = YES;
    //更新被拖拽的item
    self.dragingItem.hidden = NO;
    self.dragingItem.frame = item.frame;
    self.dragingItem.func = item.func;
    [self.dragingItem setTransform:CGAffineTransformMakeScale(1.1f, 1.1f)];
}

//正在被拖拽、、、
- (void)dragChanged:(CGPoint)point {
    if (!self.dragingIndexPath) {return;}
    self.dragingItem.center = point;
    self.targetIndexPath = [self getTargetIndexPathWithPoint:point];
    //交换位置 如果没有找到self.targetIndexPath则不交换位置
    if (self.dragingIndexPath && self.targetIndexPath) {
        //更新数据源
        [self rangeCommonFuncArr];
        //更新item位置
        [self.collectionView moveItemAtIndexPath:self.dragingIndexPath toIndexPath:self.targetIndexPath];
        self.dragingIndexPath = self.targetIndexPath;
    }
}

//拖拽结束
- (void)dragEnd{
    self.isDraging = NO;
    if (!self.dragingIndexPath) {return;}
    CGRect endFrame = [self.collectionView cellForItemAtIndexPath:self.dragingIndexPath].frame;
    [self.dragingItem setTransform:CGAffineTransformIdentity];
    [UIView animateWithDuration:0.3 animations:^{
        self.dragingItem.frame = endFrame;
    }completion:^(BOOL finished) {
        self.dragingItem.hidden = YES;
        MKBFunctionCell *item = (MKBFunctionCell *)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
        item.isMoving = NO;
    }];
}

//拖拽排序后需要重新排序数据源
- (void)rangeCommonFuncArr {
    id obj = [self.commonFuncArr objectAtIndex:self.dragingIndexPath.item];
    [self.commonFuncArr removeObjectAtIndex:self.dragingIndexPath.item];
    [self.commonFuncArr insertObject:obj atIndex:self.targetIndexPath.item];
}

//获取被拖动IndexPath的方法
-(NSIndexPath*)getDragingIndexPathWithPoint:(CGPoint)point{
    NSIndexPath* dragIndexPath = nil;
    //最后剩一个怎不可以排序
    if ([self.collectionView numberOfItemsInSection:0] == 1) {return dragIndexPath;}
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        //下半部分不需要排序
        if (indexPath.section) {continue;}
        //在上半部分中找出相对应的Item
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
//            if (indexPath.item != 0) {
                dragIndexPath = indexPath;
//            }
            break;
        }
    }
    return dragIndexPath;
}

//获取目标IndexPath的方法
-(NSIndexPath*)getTargetIndexPathWithPoint:(CGPoint)point{
    NSIndexPath *targetIndexPath = nil;
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        //如果是自己不需要排序
        if ([indexPath isEqual:self.dragingIndexPath]) {continue;}
        //第二组不需要排序
        if (indexPath.section) {continue;}
        //在第一组中找出将被替换位置的Item
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
//            if (indexPath.item != 0) {
                targetIndexPath = indexPath;
//            }
        }
    }
    return targetIndexPath;
}

/*
#pragma mark -- 点击跳转响应
- (void)itemClickResponse:(MKBFunctionModel *)func {
    switch (func.tag) {
        case ZICHAN: {
            MKBAssetsContainerController *vc = [MKBAssetsContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ZICHANGUANLI: {
            MKBAssetsManageContainerController *vc = [MKBAssetsManageContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
//            MKBMyCheckWorkController *vc = [MKBMyCheckWorkController loadNibVc];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SHITANG: {
            MKBConsumableContainerController *vc = [MKBConsumableContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case GONGCHE: {
            MKBOfficialCarContainerController *vc = [MKBOfficialCarContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case TONGQINCHE:
        case TONGQINCHESIJI: {
            MKBCommuterCarListController *vc = [MKBCommuterCarListController loadNibVc];
            vc.isDriver = func.tag == TONGQINCHESIJI;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HUIYISHI: {
            MKBRoomManageListController *vc = [MKBRoomManageListController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case HUIYI: {
            MKBMeetingController *vc = [MKBMeetingController loadNibVc];
            vc.isApproval = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case HUIYISHIYY: {
            MKBMeetingController *vc = [MKBMeetingController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case BAOXIU: {
            MKBRepairListController *vc = [MKBRepairListController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case BAOXIUSHENHE: {
            MKBApprovalRepairListController *vc = [MKBApprovalRepairListController loadNibVc];
            vc.isSolove = NO;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WEIXIUREN: {
            MKBApprovalRepairListController *vc = [MKBApprovalRepairListController loadNibVc];
            vc.isSolove = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HAOCAIGUANLI: {
            MKBConsumableManageContainerController *vc = [MKBConsumableManageContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SUSHEGUANLI: {
            MKBDormitoryContainerController *vc = [MKBDormitoryContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CHELIANGDANAN: {
            MKBCarArchivesController *vc = [MKBCarArchivesController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case DINGCAN: {
            [self jumpToOrderMeal:nil];
        }
            break;
        case SUSHESHENPI: {
            MKBDormitoryApproveContainerController *vc = [MKBDormitoryApproveContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WODESUSHE: {
            MKBUserHostelHomeController *vc = [MKBUserHostelHomeController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case FANGKE: {
            BWebController *vc = [[BWebController alloc]init];
            vc.webUrl = [NSString stringWithFormat:@"%@/visits/#/layout?mkbToken=%@", BASE_URL, [MKBStoreTool token]];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case XIYIUSER: {
            MKBLaundryUserController *vc = [MKBLaundryUserController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KUAIDI: {
            MKBExpressListController *vc = [MKBExpressListController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case XIYIYUAN: {
            MKBLaundryServiceContainerController *vc = [MKBLaundryServiceContainerController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KAOQIN: {
            MKBMyCheckWorkController *vc = [MKBMyCheckWorkController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KAOQINSHENHE: {
            MKBWorkApprovelController *vc = [MKBWorkApprovelController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ALL: {
            MKBNewFunctionController *vc = [MKBNewFunctionController loadNibVc];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)jumpToOrderMeal:(id)sender {
    [self showLoading:nil];
    [MKBBaseService postOperationWithUrl:kUrlGetMkbUserToken params:nil handler:^(BOOL success, id  _Nonnull response, NSString * _Nonnull errorMsg) {
        [self hideLoading];
        if (success) {
            BWebController *vc = [[BWebController alloc]init];
            vc.webUrl = [NSString stringWithFormat:@"%@/reserve/#/layout?supplierCode=%@&mkbToken=%@", BASE_URL, [MKBStoreTool supplierCode], response];
            [self.navigationController pushViewController:vc animated:YES];
        }else
            [self toast:errorMsg];
    }];
}
*/

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
