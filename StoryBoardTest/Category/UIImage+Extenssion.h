

#import <UIKit/UIKit.h>

@interface UIImage (Extenssion)

+ (UIImage *)resizableImageNamed:(NSString *)name;

- (UIImage *)resizableImage;

+ (UIImage *)gxz_imageWithColor:(UIColor *)color;

+ (UIImage *)videoFramerateWithPath:(NSString *)videoPath;

// 压缩图片
+ (NSData *)smartCompress:(UIImage *)originImg;
- (NSData *)smartCompress;
- (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB block:(void (^)(NSData *imageData))block;

//解决图片旋转90度的问题
+ (UIImage *)fixOrientation:(UIImage *)originImg;
- (UIImage *)fixOrientation;

+ (UIImage *)simpleImage:(UIImage *)originImg;

+ (UIImage *)makeArrowImageWithSize:(CGSize)imageSize
                              image:(UIImage *)image
                           isSender:(BOOL)isSender;

+ (UIImage *)addImage2:(UIImage *)firstImg
               toImage:(UIImage *)secondImg;

+ (UIImage *)addImage:(UIImage *)firstImg
              toImage:(UIImage *)secondImg;
//获取启动图
+ (UIImage *)getLaunchImage;

@end
