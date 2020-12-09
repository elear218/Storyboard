//
//  UIView+Addition.h
//  FYDriver
//
//  Created by 于龙 on 15/10/3.
//  Copyright © 2015年 Foryou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};
@interface UIView (Addition)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/** 获取最大x */
- (CGFloat)maxX;
/** 获取最小x */
- (CGFloat)minX;

/** 获取最大y */
- (CGFloat)maxY;
/** 获取最小y */
- (CGFloat)minY;

/** 设置最小x,相当于设置x */
- (void)setMinX:(CGFloat)minX;

/** 设置最大x */
- (void)setMaxX:(CGFloat)maxX;

/** 设置最小y,相当于设置y */
- (void)setMinY:(CGFloat)minY;

/** 设置最大y */
- (void)setMaxY:(CGFloat)maxY;
/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Shortcut for layer.transfrom
 */

- (void)setupCornerRadius:(CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)cornerRadius directions:(UIRectCorner)rectCorner;
- (void)setBorderWithWidth:(CGFloat)width andColor:(UIColor *)color;

- (void)addGraLayerWithCgColorArray:(NSArray *)colorArray;


-(void)removeAllSubviews;
-(void)removeViewWithTag:(NSInteger)tag;
-(void)removeViewWithTags:(NSArray *)tagArray;
-(void)removeViewWithTagLessThan:(NSInteger)tag;
-(void)removeViewWithTagGreaterThan:(NSInteger)tag;
- (UIViewController *)selfViewController;
-(UIView *)subviewWithTag:(NSInteger)tag;
//增加特定方向边框
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end
