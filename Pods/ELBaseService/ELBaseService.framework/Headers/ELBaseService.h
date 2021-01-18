//
//  ELBaseService.h
//  ELBaseService
//
//  Created by 正奇晟业 on 2021/1/13.
//  Copyright © 2021 elear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const kNotificationNameTokenInvalid;

@interface ELBaseService : NSObject

/**
 配置请求基地址
 */
+ (void)addBaseUrl:(NSString *)baseUrl;

/**
 配置Header
 */
+ (void)addHeader:(NSString *)header forKey:(NSString *)key;

/**
 配置通用参数
 */
+ (void)addCommonPara:(NSDictionary *)para;

/**
 移除某个通用参数
 */
+ (void)removeCommonValueByKey:(NSString *)key;

/**
 开启日志
 */
+ (void)enableDebugLog:(BOOL)enable;

/**
 网络请求（POST）

 @param urlStr 接口名
 @param params 参数
 @param handler 结果回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postOperationWithUrl:(NSString *)urlStr
                                        params:(nullable NSDictionary *)params
                                        handler:(void(^)(BOOL success, id response, NSString *errorMsg))handler;

/**
 网络请求（GET）
 
 @param urlStr 接口名
 @param params 参数
 @param handler 结果回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)getOperationWithUrl:(NSString *)urlStr
                                        params:(nullable NSDictionary *)params
                                        handler:(void(^)(BOOL success, id response, NSString *errorMsg))handler;

/**
 图片上传

 @param urlStr 接口名
 @param params 参数
 @param progress 上传进度回调
 @param handler 结果回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadImageWithUrl:(NSString *)urlStr
                                        params:(nullable NSDictionary *)params
                                        image:(UIImage *)image
                                        progress:(nullable void(^)(NSProgress *progress))progress
                                        handler:(void(^)(BOOL success, id response, NSString *errorMsg))handler;

/**
 人脸照片上传

 @param urlStr 接口名
 @param params 参数
 @param imageData 图片二进制数据
 @param progress 上传进度回调
 @param handler 结果回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadFaceImageWithUrl:(NSString *)urlStr
                                        params:(nullable NSDictionary *)params
                                        imageData:(NSData *)imageData
                                        progress:(nullable void(^)(NSProgress *progress))progress
                                        handler:(void(^)(BOOL success, id response, NSString *errorMsg))handler;

/**
 文件上传
 
 @param urlStr 接口名
 @param params 参数
 @param data 文件二进制数据
 @param fileName 文件名（带扩展名）
 @param progress 上传进度回调
 @param handler 结果回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadDataWithUrl:(NSString *)urlStr
                                        params:(nullable NSDictionary *)params
                                        data:(NSData *)data
                                        fileName:(NSString *)fileName
                                        progress:(nullable void (^)(NSProgress *progress))progress
                                        handler:(void (^)(BOOL success, id response, NSString *errorMsg))handler;

+ (void)cancelAll;
+ (void)cancelTask:(NSURLSessionDataTask *)task;

@end

NS_ASSUME_NONNULL_END
