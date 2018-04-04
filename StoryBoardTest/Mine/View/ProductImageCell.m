//
//  ProductImageCell.m
//  StoryBoardTest
//
//  Created by eall on 2018/4/3.
//  Copyright © 2018年 eall. All rights reserved.
//

#import "ProductImageCell.h"
#import <TZImagePickerController.h>

#import "PickerCollectionCell.h"

@interface ProductImageCell ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) NSMutableArray *assestArray;

@end

static NSString * const cellIdentifer = @"PickerCollectionCell";

@implementation ProductImageCell

- (NSMutableArray *)photosArray {
    if (!_photosArray) {
        _photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

- (NSMutableArray *)assestArray {
    if (!_assestArray) {
        _assestArray = [NSMutableArray array];
    }
    return _assestArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
//    UIScrollViewDecelerationRateNormal：正常减速（默认值）  0.998
//    UIScrollViewDecelerationRateFast：快速减速            0.99
//    范围是（0.0，1.0）
    _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat spacing = 10.f;
//    CGFloat itemWidth = (ScreenWidth-20*2-spacing*2)/3.0;
    CGFloat itemWidth = (ScreenWidth-60)/3.0;
    flowLayout.minimumInteritemSpacing = spacing;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    [_collectionView setCollectionViewLayout:flowLayout];

    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PickerCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifer];
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    [_collectionView reloadData];
}

//删除按钮事件
- (void)deleteBtnClik:(UIButton *)sender {
    [self.photosArray removeObjectAtIndex:sender.tag-100];
    [self.assestArray removeObjectAtIndex:sender.tag-100];
    [_collectionView reloadData];
}

#pragma mark -- 选取图片与图片预览
- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxCount delegate:self];
    imagePickerVc.selectedAssets = self.assestArray;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPreview = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _photosArray = [NSMutableArray arrayWithArray:photos];
        _assestArray = [NSMutableArray arrayWithArray:assets];
        [_collectionView reloadData];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)previewImagesAtIndexPath:(NSIndexPath *)indexPath {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_assestArray selectedPhotos:_photosArray index:indexPath.row];
    imagePickerVc.maxImagesCount = _maxCount;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPreview = NO;
    //    imagePickerVc.isSelectOriginalPhoto = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _photosArray = [NSMutableArray arrayWithArray:photos];
        _assestArray = [NSMutableArray arrayWithArray:assets];
        [_collectionView reloadData];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark <UIScrollViewDelegate>
//模拟paging效果  链接：https://stackoverflow.com/questions/24303883/uicollectionview-with-paging-enable#
//https://stackoverflow.com/questions/20496850/uicollectionview-with-paging-setting-page-width
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat cellWidth = (ScreenWidth-60)/3.0;
    CGFloat cellPadding = 10.f;
    
    NSInteger page = (scrollView.contentOffset.x - cellWidth / 2) / (cellWidth + cellPadding) + 1;
    
    if (velocity.x > 0) page++;
    if (velocity.x < 0) page--;
    page = MAX(page,0);
    
    CGFloat newOffset = page * (cellWidth + cellPadding);
    targetContentOffset->x = newOffset;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _maxCount == self.photosArray.count ? self.photosArray.count : self.photosArray.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PickerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    if (_maxCount == self.photosArray.count) {
        //图片选择达到上限  不再显示添加按钮
        cell.deleteBtn.hidden = NO;
        cell.imageV.image = self.photosArray[indexPath.row];
    }else {
        //未达到选择上限  最后一位显示加号按钮
        if (indexPath.row == self.photosArray.count) {
            //加号
            cell.imageV.image = [UIImage imageNamed:@"photo_add"];
            cell.deleteBtn.hidden = YES;
        }else {
            //图片
            cell.imageV.image = self.photosArray[indexPath.row];
            cell.deleteBtn.hidden = NO;
        }
    }
    cell.deleteBtn.tag = 100 + indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_maxCount == self.photosArray.count) {
        //图片选择达到上限  全部显示预览
        [self previewImagesAtIndexPath:indexPath];
    }else {
        //未达到选择上限
        if (indexPath.row == self.photosArray.count) {
            //选取图片
            [self pushTZImagePickerController];
        }else {
            //浏览图片
            [self previewImagesAtIndexPath:indexPath];
        }
    }
}

@end
