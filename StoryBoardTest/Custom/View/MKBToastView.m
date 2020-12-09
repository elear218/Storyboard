//
//  MKBToastView.m
//  MKBLogistics
//
//  Created by 正奇晟业 on 2020/6/5.
//  Copyright © 2020 正奇晟业. All rights reserved.
//

#import "MKBToastView.h"

@implementation MKBToastView

- (CGSize)intrinsicContentSize {
    return CGSizeMake(80, 80);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}
@end
