


#import "UIImage+Extenssion.h"
#import <AVFoundation/AVFoundation.h>
@implementation UIImage (Extenssion)

+ (UIImage *)resizableImageNamed:(NSString *)name {
     return  [[self imageNamed:name] resizableImage];
}

- (UIImage *) resizableImage {
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height * 0.5, self.size.width * 0.5, self.size.height * 0.5, self.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)gxz_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 视频第一帧
+ (UIImage *)videoFramerateWithPath:(NSString *)videoPath {
    NSString *mp4Path = [[videoPath stringByDeletingPathExtension] stringByAppendingPathExtension:@"mp4"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:mp4Path] options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 0;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    if (!thumbnailImageRef) {
        return nil;
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    CGImageRelease(thumbnailImageRef);
    return thumbnailImage;
}

// 压缩图片
+ (NSData *)smartCompress:(UIImage *)originImg {
    return [originImg smartCompress];
}
- (NSData *)smartCompress {
    // https://www.jianshu.com/p/66164b9a7692
    /** 仿微信算法 **/
    UIImage *tempImage = self;
    NSInteger width = (int)self.size.width;
    NSInteger height = (int)self.size.height;
    NSInteger updateWidth = width;
    NSInteger updateHeight = height;
    NSInteger longSide = MAX(width, height);
    NSInteger shortSide = MIN(width, height);
    CGFloat scale = shortSide * .1 / longSide;
    
    // 大小压缩
    if (shortSide < 1080 || longSide < 1080) { // 如果宽高任何一边都小于 1080
        updateWidth = width;
        updateHeight = height;
    } else { // 如果宽高都大于 1080
        if (width < height) { // 说明短边是宽
            updateWidth = 1080;
            updateHeight = (int)(1080 / scale);
        } else { // 说明短边是高
            updateWidth = (int)(1080 / scale);
            updateHeight = 1080;
        }
    }
    CGSize size = CGSizeMake(updateWidth, updateHeight);
    UIGraphicsBeginImageContext(size);
    [tempImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *resultData = UIImageJPEGRepresentation(image, .3f);
    return resultData;
}

- (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB block:(void (^)(NSData *))block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // Compress by quality
        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(self, compression);
        if (data.length / 1000 < maxLengthKB) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"质量压缩完成： %zd kb", data.length / 1000);
                block(data);
            });
            return;
        }
        
        //二分法压缩
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(self, compression);
            if (data.length / 1000 < maxLengthKB * 0.9) {
                min = compression;
            } else if (data.length / 1000 > maxLengthKB) {
                max = compression;
            } else {
                break;
            }
        }
        if (data.length / 1000 < maxLengthKB) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"质量压缩完成： %zd kb", data.length / 1000);
                block(data);
            });
            return;
        }
        
        // Compress by size
        UIImage *image = [UIImage imageWithData:data];
        NSUInteger lastDataLength = 0;
        while (data.length / 1000 > maxLengthKB && data.length != lastDataLength) {
            lastDataLength = data.length;
            CGFloat ratio = (CGFloat)maxLengthKB / (data.length / 1000);
            CGSize size = CGSizeMake((NSUInteger)(image.size.width * sqrtf(ratio)),
                                     (NSUInteger)(image.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
            UIGraphicsBeginImageContext(size);
            [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(image, compression);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"尺寸压缩完成： %ld kb", data.length / 1000);
            block(data);
        });
    });
}

+ (UIImage *)fixOrientation:(UIImage *)originImg {
    return [originImg fixOrientation];
}

/**
一种是获取图片自带的位置属性,重新设置正方向,使图片恢复正向摆放.

另一种就是直接缩放图片尺寸,绘制后使其恢复正向.后者反应速度更快.
*/
- (UIImage *)fixOrientation {
    /*
    //第一种，调整方向
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
      
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
      
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
              
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
              
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
      
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
              
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
      
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
              
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }
      
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
    */
    
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    int destWidth = self.size.width;
    int destHeight = self.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(destWidth, destHeight));
    [self drawInRect:CGRectMake(0, 0, destWidth, destHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)simpleImage:(UIImage *)originImg {
    CGSize imageSize = [self handleImage:originImg.size];
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    CGContextAddPath(contextRef, bezierPath.CGPath);
    CGContextClip(contextRef);
    [originImg drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *clipedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipedImage;
}

+ (CGSize)handleImage:(CGSize)retSize {
    CGFloat width = 0;
    CGFloat height = 0;
    if (retSize.width > retSize.height) {
        width = ScreenWidth;
        height = retSize.height / retSize.width * width;
    } else {
        height = ScreenHeight;
        width = retSize.width / retSize.height * height;
    }
    return CGSizeMake(width, height);
}


+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender {
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [self getBezierPath:isSender imageSize:imageSize];
    CGContextAddPath(contextRef, path.CGPath);
    CGContextEOClip(contextRef);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *arrowImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return arrowImage;
}

+ (UIBezierPath *)getBezierPath:(BOOL)isSender
                      imageSize:(CGSize)imageSize {
    CGFloat arrowWidth = 6;
    CGFloat marginTop = 5;
    CGFloat arrowHeight = 10;
    CGFloat imageW = imageSize.width;
    CGFloat imageH = imageSize.height;
    UIBezierPath *path;
    if (isSender) {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width - arrowWidth, imageSize.height) cornerRadius:6];
        [path moveToPoint:CGPointMake(imageW - arrowWidth, imageH)];
        [path addLineToPoint:CGPointMake(imageW - arrowWidth, imageH - marginTop)];
        [path addLineToPoint:CGPointMake(imageW, imageH - marginTop)];
        [path addLineToPoint:CGPointMake(imageW - arrowWidth, imageH - marginTop-0.5*arrowHeight)];
        [path closePath];
        
    } else {
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(arrowWidth, 0, imageSize.width - arrowWidth, imageSize.height) cornerRadius:6];
        [path moveToPoint:CGPointMake(arrowWidth, imageH)];
        [path addLineToPoint:CGPointMake(arrowWidth, imageH - marginTop)];
        [path addLineToPoint:CGPointMake(0, imageH - marginTop)];
        [path addLineToPoint:CGPointMake(arrowWidth, imageH-marginTop-0.5*arrowHeight)];
        [path closePath];
    }
    return path;
}

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg {
    UIGraphicsBeginImageContext(secondImg.size);
    [secondImg drawInRect:CGRectMake(0, 0, secondImg.size.width, secondImg.size.height)];
    [firstImg drawInRect:CGRectMake((secondImg.size.width-firstImg.size.width)*0.5,(secondImg.size.height-firstImg.size.height)*0.5, firstImg.size.width, firstImg.size.height)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg {
    UIGraphicsBeginImageContext(secondImg.size);
    [secondImg drawInRect:CGRectMake(0, 0,secondImg.size.width,secondImg.size.height)];
    CGFloat firstImgW = secondImg.size.width/4;
    CGFloat firstImgH = secondImg.size.width/4;
    [firstImg drawInRect:CGRectMake((secondImg.size.width-firstImgW)*0.5,(secondImg.size.height-firstImgH)*0.5, firstImgW,firstImgH)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage *)getLaunchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString * image = nil;
    NSArray * array = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary * dict in array) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize)) {
            image = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:image];
}
@end
