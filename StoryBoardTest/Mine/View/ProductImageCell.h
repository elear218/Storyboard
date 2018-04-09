//
//  ProductImageCell.h
//  StoryBoardTest
//
//  Created by eall on 2018/4/3.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger maxCount;

@end
