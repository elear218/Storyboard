//
//  MKBFunctionHeader.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/9/16.
//  Copyright © 2020 elear. All rights reserved.
//

#import "MKBFunctionHeader.h"

@interface MKBFunctionHeader ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *commonCollectionView;

@end

@implementation MKBFunctionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = ScreenWidth;
    [self layoutIfNeeded];
}

- (IBAction)editBtnClick:(id)sender {
    !self.editBlock ? : self.editBlock();
}

- (void)setCommonFuncArr:(NSArray<MKBFunctionModel *> *)commonFuncArr {
    _commonFuncArr = commonFuncArr;
    self.commonCollectionView.delegate = self;
    self.commonCollectionView.dataSource = self;
    [self.commonCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MKBLittleFunctionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MKBLittleFunctionCell class])];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self.commonCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.commonFuncArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(25.f, 25.f);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MKBLittleFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MKBLittleFunctionCell class]) forIndexPath:indexPath];
    cell.func = self.commonFuncArr[indexPath.item];
    return cell;
}

@end
