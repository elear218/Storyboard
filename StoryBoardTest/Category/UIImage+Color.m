//
//  UIImage+Color.m
//  StoryBoardTest
//
//  Created by 正奇晟业 on 2020/12/9.
//  Copyright © 2020 eall. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    return [baseImage colorizewithColor:theColor];
}

- (UIImage *)colorizewithColor:(UIColor *)theColor {
    /*
     //获取画布
     UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
     //画笔沾取颜色
     [theColor setFill];
     CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
     //绘制一次
     UIRectFill(bounds);
     //再绘制一次
     [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
     //获取图片
     [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return image;
     */
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [theColor setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    /*
    //非白色图片效果不好
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);

    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, self.CGImage);

    [theColor set];
    CGContextFillRect(ctx, area);

    CGContextRestoreGState(ctx);

    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);

    CGContextDrawImage(ctx, area, self.CGImage);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
    */
}

@end
