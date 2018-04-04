//
//  PublishCollectionViewController.m
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "PublishCollectionViewController.h"
#import <TZImagePickerController.h>

/** *** 试图类 *** */
#import "InputTFCell.h"
#import "InputTVCell.h"
#import "ImagePickerCell.h"
#import "ImageSectionHeaderReusableView.h"

@interface PublishCollectionViewController ()<TZImagePickerControllerDelegate>{
    NSArray *imageModelArr/**图片本地模型类数组*/;
    CGSize imageItemSize; //选择图片item大小
}

@property (nonatomic, strong) NSMutableArray *inputArr;

@property (nonatomic, strong) NSMutableArray<UIImage *> *mainImgArr;
@property (nonatomic, strong) NSMutableArray *mainAssetArr;

@property (nonatomic, strong) NSMutableArray<UIImage *> *cycleImgArr;
@property (nonatomic, strong) NSMutableArray *cycleAssetArr;

@property (nonatomic, strong) NSMutableArray<UIImage *> *detailImgArr;
@property (nonatomic, strong) NSMutableArray *detailAssetArr;

@property (nonatomic, copy) NSDictionary *totalImageDic; /**保存三种图片数组与asset数组*/

@property (nonatomic, assign) NSInteger maxCount; //图片最大选择个数

@property (nonatomic, strong) ProductFormModel *uploadModel;

@end

@implementation PublishCollectionViewController

static NSString * const inputTFReuseIdentifier = @"InputTFCell";
static NSString * const inputTVReuseIdentifier = @"InputTVCell";
static NSString * const imagePickReuseIdentifier = @"ImagePickerCell";
static NSString * const imageHeaderReuseIdentifier = @"ImageSectionHeaderReusableView";
static NSString * const sectionFooterReuseIdentifier = @"SectionFooterReusableView";

static CGFloat const itemLineSpacing = 10.f; //同一组当中，垂直方向：行与行之间的间距；水平方向：列与列之间的间距
static CGFloat const itemInteritemSpacing = 10.f; //垂直方向：同一行中的cell之间的间距；水平方向：同一列中，cell与cell之间的间距
static CGFloat const sectionEdge = 20.f;

#pragma mark -- 懒加载
- (ProductFormModel *)uploadModel {
    if (!_uploadModel) {
        _uploadModel = [[ProductFormModel alloc] init];
    }
    return _uploadModel;
}

- (NSMutableArray *)inputArr {
    if (!_inputArr) {
        _inputArr = [NSMutableArray array];
    }
    return _inputArr;
}

- (NSMutableArray *)mainImgArr {
    if (!_mainImgArr) {
        _mainImgArr = [NSMutableArray array];
    }
    return _mainImgArr;
}

- (NSMutableArray *)mainAssetArr {
    if (!_mainAssetArr) {
        _mainAssetArr = [NSMutableArray array];
    }
    return _mainAssetArr;
}

- (NSMutableArray *)cycleImgArr {
    if (!_cycleImgArr) {
        _cycleImgArr = [NSMutableArray array];
    }
    return _cycleImgArr;
}

- (NSMutableArray *)cycleAssetArr {
    if (!_cycleAssetArr) {
        _cycleAssetArr = [NSMutableArray array];
    }
    return _cycleAssetArr;
}

- (NSMutableArray *)detailImgArr {
    if (!_detailImgArr) {
        _detailImgArr = [NSMutableArray array];
    }
    return _detailImgArr;
}

- (NSMutableArray *)detailAssetArr {
    if (!_detailAssetArr) {
        _detailAssetArr = [NSMutableArray array];
    }
    return _detailAssetArr;
}

- (NSDictionary *)totalImageDic {
    if (!_totalImageDic) {
        _totalImageDic = @{@"photo" : @[self.mainImgArr, self.cycleImgArr, self.detailImgArr],
                           @"asset" : @[self.mainAssetArr, self.cycleAssetArr, self.detailAssetArr]
                           };
    }
    return _totalImageDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    参考文章：写一个iOS复杂表单的正确姿势（https://www.jianshu.com/p/4a3aad22f356）
    
    [self contentInsetAdjustment];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    CGFloat itemWidth = (ScreenWidth-sectionEdge*2-itemInteritemSpacing*2)/3;
    imageItemSize = CGSizeMake(itemWidth, itemWidth);
    
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    // Register cell classes
    [self.collectionView registerClass:[InputTFCell class] forCellWithReuseIdentifier:inputTFReuseIdentifier];
    [self.collectionView registerClass:[InputTVCell class] forCellWithReuseIdentifier:inputTVReuseIdentifier];
    [self.collectionView registerClass:[ImagePickerCell class] forCellWithReuseIdentifier:imagePickReuseIdentifier];
    [self.collectionView registerClass:[ImageSectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:imageHeaderReuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionFooterReuseIdentifier];
    
    [self initInputData];
    [self initImgData];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- 本地数据初始化
- (void)initInputData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CreateFormModel *classificationModel = [[CreateFormModel alloc] init];
        classificationModel.title = @"选择分类";
        classificationModel.placeholder = @"请选择商品二级分类";
        classificationModel.isAccessory = YES;
        classificationModel.key = @"classification";
        classificationModel.cellType = CreateCellTypeClick;
        classificationModel.keyboardType = InputKeyboardTypeAll;
        [self.inputArr addObject:classificationModel];
        
        CreateFormModel *titleModel = [[CreateFormModel alloc] init];
        titleModel.title = @"商品标题";
        titleModel.placeholder = @"请输入商品标题";
        titleModel.isAccessory = NO;
        titleModel.key = @"title";
        titleModel.cellType = CreateCellTypeFieldInput;
        titleModel.keyboardType = InputKeyboardTypeAll;
        [self.inputArr addObject:titleModel];
        
        CreateFormModel *priceModel = [[CreateFormModel alloc] init];
        priceModel.title = @"价格";
        priceModel.placeholder = @"请输入商品价格";
        priceModel.isAccessory = YES;
        priceModel.key = @"price";
        priceModel.cellType = CreateCellTypeFieldInput;
        priceModel.keyboardType = InputKeyboardTypeFloat;
        [self.inputArr addObject:priceModel];
        
        CreateFormModel *countModel = [[CreateFormModel alloc] init];
        countModel.title = @"单人限购件数";
        countModel.placeholder = @"请输入限购件数";
        countModel.isAccessory = NO;
        countModel.key = @"count";
        countModel.cellType = CreateCellTypeFieldInput;
        countModel.keyboardType = InputKeyboardTypeInt;
        [self.inputArr addObject:countModel];
        
        CreateFormModel *expiryModel = [[CreateFormModel alloc] init];
        expiryModel.title = @"有效期";
        expiryModel.placeholder = @"请选择天数";
        expiryModel.isAccessory = YES;
        expiryModel.key = @"expiry";
        expiryModel.cellType = CreateCellTypeClick;
        [self.inputArr addObject:expiryModel];
        
        CreateFormModel *supportModel = [[CreateFormModel alloc] init];
        supportModel.title = @"支持项";
        supportModel.placeholder = @"请选择支持项";
        supportModel.isAccessory = YES;
        supportModel.key = @"support";
        supportModel.cellType = CreateCellTypeClick;
        [self.inputArr addObject:supportModel];
        
        CreateFormModel *descripModel = [[CreateFormModel alloc] init];
        descripModel.title = @"详情描述";
        descripModel.placeholder = @"请输入描述内容";
        descripModel.key = @"descriptionContent";
        descripModel.cellType = CreateCellTypeViewInput;
        [self.inputArr addObject:descripModel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        });
    });
}

- (void)initImgData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CreateFormModel *mainModel = [[CreateFormModel alloc] init];
        mainModel.title = @"商品主图";
        mainModel.placeholder = @"1张";
        mainModel.imgMaxCount = 1;
        //        mainModel.key = @"mainImg";
        
        CreateFormModel *cycleModel = [[CreateFormModel alloc] init];
        cycleModel.title = @"商品轮播图";
        cycleModel.placeholder = @"最多5张";
        cycleModel.imgMaxCount = 5;
        //        cycleModel.key = @"cycleImg";
        
        CreateFormModel *detailModel = [[CreateFormModel alloc] init];
        detailModel.title = @"商品详情图";
        detailModel.placeholder = @"最多9张";
        detailModel.imgMaxCount = 9;
        //        detailModel.key = @"detailImg";
        
        imageModelArr = [NSArray arrayWithObjects:mainModel,cycleModel,detailModel, nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)]];
        });
    });
}

#pragma mark -- 选取图片与图片预览
- (void)pushTZImagePickerControllerAtSection:(NSInteger)section {
    __block NSMutableArray *_photosArray = self.totalImageDic[@"photo"][section-1];
    __block NSMutableArray *_assetsArray = self.totalImageDic[@"asset"][section-1];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxCount delegate:self];
    imagePickerVc.selectedAssets = _assetsArray;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    //    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.allowPreview = YES;
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        __strong typeof(self) strongSelf = weakSelf;
        [_photosArray removeAllObjects];
        [_photosArray addObjectsFromArray:photos];
        [_assetsArray removeAllObjects];
        [_assetsArray addObjectsFromArray:assets];
        [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }];
    imagePickerVc.navigationBar.barTintColor = kHexColor(0x0084ff);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)previewImagesAtIndexPath:(NSIndexPath *)indexPath {
    __block NSMutableArray *_photosArray = self.totalImageDic[@"photo"][indexPath.section-1];
    __block NSMutableArray *_assetsArray = self.totalImageDic[@"asset"][indexPath.section-1];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_assetsArray selectedPhotos:_photosArray index:indexPath.row];
    imagePickerVc.maxImagesCount = _maxCount;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPreview = NO;
    //    imagePickerVc.isSelectOriginalPhoto = NO;
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        __strong typeof(self) strongSelf = weakSelf;
        _photosArray = [NSMutableArray arrayWithArray:photos];
        _assetsArray = [NSMutableArray arrayWithArray:assets];
        [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        CreateFormModel *model = self.inputArr[indexPath.row];
        return model.cellType == CreateCellTypeViewInput ? CGSizeMake(ScreenWidth, 160) : CGSizeMake(ScreenWidth, 60);
    }
    
    return imageItemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (0 == section) {
        return UIEdgeInsetsZero;
    }
    return UIEdgeInsetsMake(5, sectionEdge, 20, sectionEdge);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0 == section ? .1f : itemLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0 == section ? .1f : itemInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (0 != section) {
        return CGSizeMake(ScreenWidth, 50);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, section == 3 ? .1f : 10);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.inputArr.count;
    }
    
    if (!imageModelArr) {
        return 1;
    }
    
    NSMutableArray *arr = self.totalImageDic[@"photo"][section-1];
    return [arr count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        CreateFormModel *model = self.inputArr[indexPath.row];
        
        if (model.cellType == CreateCellTypeViewInput) {
            InputTVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:inputTVReuseIdentifier forIndexPath:indexPath];
            [cell refreshContent:model uploadModel:self.uploadModel];
            return cell;
        }
        
        InputTFCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:inputTFReuseIdentifier forIndexPath:indexPath];
        [cell refreshContent:model uploadModel:self.uploadModel];
        return cell;
    }
    
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imagePickReuseIdentifier forIndexPath:indexPath];
    
    NSMutableArray *photo = self.totalImageDic[@"photo"][indexPath.section-1];
    NSMutableArray *asset = self.totalImageDic[@"asset"][indexPath.section-1];
    if (indexPath.row == photo.count) {
        [cell setImage:[UIImage imageNamed:@"photo_add"] isAdd:YES];
    }else {
        [cell setImage:photo[indexPath.row] isAdd:NO];
    }
    
    __weak typeof(self) weakSelf = self;
    cell.deleteClick = ^{
        __strong typeof(self) strongSelf = weakSelf;
        [photo removeObjectAtIndex:indexPath.row];
        [asset removeObjectAtIndex:indexPath.row];
        [strongSelf.collectionView performBatchUpdates:^{
            [strongSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
            //防止闪烁
            [UIView performWithoutAnimation:^{
                [strongSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            }];
        }];
    };
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //区头
    if (UICollectionElementKindSectionHeader == kind) {
        if (0 != indexPath.section) {
            ImageSectionHeaderReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:imageHeaderReuseIdentifier forIndexPath:indexPath];
            if (imageModelArr) {
                CreateFormModel *model = imageModelArr[indexPath.section-1];
                reusableview.model = model;
            }
            return reusableview;
        }
        return nil;
    }
    
    //区尾
    UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionFooterReuseIdentifier forIndexPath:indexPath];
    reusableview.backgroundColor = [UIColor colorWithRed:242/255.f green:243/255.f blue:248/255.f alpha:1];
    return reusableview;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        
    }else {
        NSMutableArray *arr = self.totalImageDic[@"photo"][indexPath.section-1];
        CreateFormModel *model = imageModelArr[indexPath.section-1];
        _maxCount = model.imgMaxCount;
        if (indexPath.row == arr.count) {
            //跳转相册选择照片
            [self pushTZImagePickerControllerAtSection:indexPath.section];
        }else {
            //预览选中
            [self previewImagesAtIndexPath:indexPath];
        }
    }
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
