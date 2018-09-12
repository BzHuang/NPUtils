//
//  UIImage+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NPExtension
@interface UIImage (NPExtension)

///根据图片名，从本地加载图片
+ (instancetype)np_imageOfFile:(NSString *)file;

@end

#pragma mark -
#pragma mark - NPSize 尺寸
@interface UIImage (NPSize)

- (CGFloat)np_width;

- (CGFloat)np_height;

//////根据图片的比例 由高取宽
- (CGFloat)np_widthOfHeight:(CGFloat)height;


///根据图片的比例 由宽取高
- (CGFloat)np_heightOfWidth:(CGFloat)width;

///自由改变Image的大小 size 目的大小
- (UIImage *)np_makeSizeWithTargetSize:(CGSize)targetSize;

/**
 修改图片size

 @param image 原图片
 @param targetSize 要修改的size
 @return 修改size后的图片
 */
+ (UIImage *)np_makeSizeImage:(UIImage*)image
                   targetSize:(CGSize)targetSize;

/**
 压缩图片的文件大小

 @param image 图片
 @param maxFileSize 最大的内存大小 单位KB
 @return 压缩后的图片
 */
+ (UIImage *)np_compressImage:(UIImage *)image
                maxFileSize:(NSInteger)maxFileSize;

/**
 自由拉伸一张图片

 @param left 左边开始位置比例  值范围0-1
 @param top 上边开始位置比例  值范围0-1
 @return 拉伸后的Image
 */
- (UIImage *)np_resizedWithleft:(CGFloat)left
                              top:(CGFloat)top;

///缩放图片到指定大小
- (UIImage*)np_scaleToSize:(CGSize)size;


@end;


#pragma mark -
#pragma mark - NPColor 颜色
@interface UIImage (NPColor)

///根据颜色生成Image
+ (UIImage *)np_imageWithColor:(UIColor *)color;

/**
 根据颜色和大小生成Image

 @param color 颜色
 @param size 大小
 @return 图片
 */
+ (UIImage *)np_imageWithColor:(UIColor *)color
                          size:(CGSize)size;


///根据图片和颜色返回一张加深颜色以后的图片
+ (UIImage *)np_colorizeOriginalImage:(UIImage *)originalImage
                        color:(UIColor *)color;

///改变图片的颜色
- (UIImage *)np_imageWithTintColor:(UIColor *)tintColor;

///
- (UIImage *)np_imageWithGradientTintColor:(UIColor *)tintColor;

///变灰
+ (UIImage*)np_grayImage:(UIImage*)sourceImage;
///变灰
+ (UIImage*)np_grayScaleImageForImage:(UIImage*)image;

@end


#pragma mark - 
#pragma mark - NPScreenshot 截图、裁切
@interface UIImage (NPScreenshot)

///裁切成圆
- (UIImage *)np_cutIntoRound;

///从给定UIImage和指定Frame截图：
- (UIImage *)np_cutWithFrame:(CGRect)frame;

///截取当前屏幕
+ (UIImage *)np_cutScreen;

///从给定UIView中截图：UIView转UIImage
+ (UIImage *)np_cutFromView:(UIView *)view;

///分割图片
- (NSArray *)np_createSubImageWithCount:(NSInteger)count;

///修正图片方向
+ (UIImage *)np_fixOrientation:(UIImage *)aImage;
- (UIImage *)np_fixOrientation;

@end


#pragma mark -
#pragma mark - NPBlur 高斯模糊
@interface UIImage (NPBlur)

///据图片返回一张高斯模糊的图片
- (UIImage *)np_blurImageWithBlur:(CGFloat)blur;

@end

#pragma mark -
#pragma mark - NPCompress 压缩
@class ALAssetRepresentation;
@interface UIImage (NPCompress)

///压缩到大约指定体积大小(kb) 返回压缩后图片
- (UIImage *)np_compressImageWithSize:(CGFloat)size;

///压缩到大约指定体积大小(kb) 返回data
- (NSData *)np_compressImageDataWithSize:(CGFloat)size;

///快速压缩 压缩到大约指定体积大小(kb) 返回压缩后图片
- (UIImage *)np_fastestCompressImageWithSize:(CGFloat)size;

///快速压缩 压缩到大约指定体积大小(kb) 返回data
- (NSData *)np_fastestCompressImageDataWithSize:(CGFloat)size;

///微调压缩 压缩到大约指定体积大小(kb) 返回data
- (NSData *)np_microCompressImageDataWithSize:(CGFloat)size;


@end

#pragma mark -
#pragma mark - NPWater 水印

///水印方向
typedef NS_ENUM(NSInteger,NPImageWaterPosition) {

    //左上
    NPImageWaterPosition_TopLeft = 0,
    //右上
    NPImageWaterPosition_TopRight,
    //左下
    NPImageWaterPosition_BottomLeft,
    //右下
    NPImageWaterPosition_BottomRight,
    //正中
    NPImageWaterPosition_Center
};

@interface UIImage (NPWater)

- (UIImage *)waterWithText:(NSString *)text
                 direction:(NPImageWaterPosition)direction
                 fontColor:(UIColor *)fontColor
                 fontPoint:(CGFloat)fontPoint
                  marginXY:(CGPoint)marginXY;

- (UIImage *)waterWithWaterImage:(UIImage *)waterImage
                      direction:(NPImageWaterPosition)direction
                      waterSize:(CGSize)waterSize
                       marginXY:(CGPoint)marginXY;

@end




