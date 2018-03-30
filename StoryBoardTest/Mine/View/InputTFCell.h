//
//  InputTFCell.h
//  StoryBoardTest
//
//  Created by eall on 2018/3/30.
//  Copyright © 2018年 eall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductFormModel.h"

@interface InputTFCell : UICollectionViewCell

- (void)refreshContent:(CreateFormModel *)createModel uploadModel:(ProductFormModel *)uploadModel;

@end
