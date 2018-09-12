//
//  UIImage+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UIImage+NPExtension.h"
#import <Accelerate/Accelerate.h>
#import <ImageIO/CGImageSource.h>

@implementation UIImage (NPExtension)

// 根据图片名，从本地加载图片
+ (instancetype)np_imageOfFile:(NSString *)file{

    NSString *imageName = file;
//    UIImage * tempImage = nil;
//    NSString * imagePath  = [[NSBundle mainBundle]pathForResource:file ofType:@"png"];
//    tempImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
//    if (!tempImage) {
//        tempImage = [UIImage imageNamed:imageName];
//    }
//    return tempImage ;
    
//    先拿2倍图
    NSString *doubleImage  = [imageName stringByAppendingString:@"@2x"];
    NSString *tribleImage  = [imageName stringByAppendingString:@"@3x"];
    NSString *bundlePath   = [NSBundle mainBundle].bundlePath;
    NSString *path = nil;
    
    NSArray *array = [NSBundle pathsForResourcesOfType:nil inDirectory:bundlePath];
    NSString *fileExt = [[array.firstObject lastPathComponent] pathExtension];
    if ([UIScreen mainScreen].scale == 3.0) {
        path = [NSBundle pathForResource:tribleImage ofType:fileExt inDirectory:bundlePath];
    }
    path = path ? path : [NSBundle pathForResource:doubleImage ofType:fileExt inDirectory:bundlePath]; //取二倍图
    path = path ? path : [NSBundle pathForResource:imageName ofType:fileExt inDirectory:bundlePath]; //实在没了就去取一倍图
    return [UIImage imageWithContentsOfFile:path];
}


@end


#pragma mark -
#pragma mark - NPSize 尺寸
@implementation UIImage (NPSize)

- (CGFloat)np_width{
    return self.size.width;
}

- (CGFloat)np_height{
    return self.size.height;
}

- (CGFloat)np_widthOfHeight:(CGFloat)height{
    return height * (self.size.width / self.size.height);
}

- (CGFloat)np_heightOfWidth:(CGFloat)width{
    return  width / (self.size.width / self.size.height);
}

//自由改变Image的大小
- (UIImage *)np_makeSizeWithTargetSize:(CGSize)targetSize {
    
    float scale = self.size.width/self.size.height;
    CGSize size = targetSize;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height) {
        
        rect.origin.x = (self.size.width - self.size.height * size.width/size.height)/2.0;
        rect.size.width  = self.size.height * size.width/size.height;
        rect.size.height = self.size.height;
        
    }else {
        
        rect.origin.y = (self.size.height - self.size.width/size.width * size.height)/2.0;
        rect.size.width  = self.size.width;
        rect.size.height = self.size.width/size.width * size.height;
        
    }

    CGImageRef imageRef   = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

+ (UIImage *)np_makeSizeImage:(UIImage *)image
                   targetSize:(CGSize)targetSize
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage ;
}

+ (UIImage *)np_compressImage:(UIImage *)image
                  maxFileSize:(NSInteger)maxFileSize{
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] / 1024.0 > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

//自由拉伸一张图片
- (UIImage *)np_resizedWithleft:(CGFloat)left
                         top:(CGFloat)top
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}

- (UIImage*)np_scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = floorf(width*radio);
    height = floorf(height*radio);
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end


#pragma mark -
#pragma mark - NPColor 颜色
@implementation UIImage (NPColor)

+ (UIImage *)np_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

// 根据颜色和大小获取Image
+ (UIImage *)np_imageWithColor:(UIColor *)color
                          size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 根据图片和颜色返回一张加深颜色以后的图片
+ (UIImage *)np_colorizeOriginalImage:(UIImage *)originalImage
                                color:(UIColor *)color {
    
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width*2, originalImage.size.height*2));
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, originalImage.size.width * 2, originalImage.size.height * 2);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, originalImage.CGImage);
    
    [color set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, originalImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)np_imageWithTintColor:(UIColor *)tintColor
{
    return [self np_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)np_imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self np_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

- (UIImage *)np_imageWithTintColor:(UIColor *)tintColor
                         blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage*)np_grayImage:(UIImage*)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height,8,0, colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context ==NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

///
+(UIImage*)np_grayScaleImageForImage:(UIImage *)image {
    // Adapted from this thread: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, image.size.width* image.scale, image.size.height* image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}

@end

#pragma mark -
#pragma mark - NPScreenshot 截图
@implementation UIImage (NPScreenshot)

- (UIImage *)np_cutIntoRound
{
    //获取size
    CGSize size = self.size;
    CGFloat wh = MIN(size.width, size.height);
    size = CGSizeMake(wh, wh);

    CGRect rect = (CGRect){CGPointZero,size};
    
    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //绘制圆形路径
    CGContextAddEllipseInRect(ctx, rect);
    
    //剪裁上下文
    CGContextClip(ctx);
    
    //绘制图片
    [self drawInRect:rect];
    //取出图片
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return roundImage;
}

- (UIImage *)np_cutWithFrame:(CGRect)frame{
    
    //创建CGImage
    CGImageRef cgimage = CGImageCreateWithImageInRect(self.CGImage, frame);
    //创建image
    UIImage *newImage=[UIImage imageWithCGImage:cgimage];
    //释放CGImage
    CGImageRelease(cgimage);
    return newImage;
}

//直接截屏
+ (UIImage *)np_cutScreen{
    return [self np_cutFromView:[UIApplication sharedApplication].keyWindow];
}

+ (UIImage *)np_cutFromView:(UIView *)view{
 //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //在新建的图形上下文中渲染view的layer
    [view.layer renderInContext:context];
    
    [[UIColor clearColor] setFill];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

- (NSArray *)np_createSubImageWithCount:(NSInteger)count{
    // 计算列数
    int columnRow = (int)sqrt(count);
    CGFloat imageW = self.size.width / columnRow;
    CGFloat imageH = self.size.height / columnRow;
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        CGFloat imageX = (i % columnRow) * imageW;
        CGFloat imageY = (i / columnRow) * imageH;
        CGImageRef subCGImage = CGImageCreateWithImageInRect([self CGImage], CGRectMake(imageX, imageY, imageW, imageH));
        UIImage *subImage = [UIImage imageWithCGImage:subCGImage];
        CGImageRelease(subCGImage);
        [imageArray addObject:subImage];
    }
    
    return imageArray;
}
- (UIImage *)np_fixOrientation{
    return [UIImage np_fixOrientation:self];
}

+ (UIImage *)np_fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end

#pragma mark -
#pragma mark - NPBlur 高斯模糊
@implementation UIImage (NPBlur)

/// 根据图片返回一张高斯模糊的图片
- (UIImage *)np_blurImageWithBlur:(CGFloat)blur
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1); // convert to jpeg
    UIImage* destImage = [UIImage imageWithData:imageData];
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = destImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    return returnImage;
}

@end

#pragma mark -
#pragma mark - NPCompress 压缩
@implementation UIImage (NPCompress)

/** 微调压缩 压缩到大约指定体积大小(kb) 返回data */
- (NSData *)np_microCompressImageDataWithSize:(CGFloat)size
{
    return [self np_microCompressImageSize:size];
}

- (NSData *)np_microCompressImageSize:(CGFloat)size
{
    /** 临时图片 */
    UIImage *compressedImage = self;
    CGFloat targetSize = size * 1024; // 压缩目标大小
    CGFloat percent = 0.9f; // 压缩系数
    /** 微调参数 */
    NSInteger microAdjustment = 5*1024;
    
    /** 记录上一次的压缩大小 */
    NSInteger imageDatalength = 0;
    
    NSData *imageData = nil;
    
    /** 压缩核心方法 */
    do {
        if (percent < 0.01) {
            /** 压缩系数不能少于0 */
            percent = 0.1f;
        }
        imageData = UIImageJPEGRepresentation(compressedImage, percent);
        
        //        NSLog(@"压缩后大小:%ldk, 压缩频率:%ldk", imageData.length/1024, (imageDatalength - imageData.length)/1024);
        // 压缩精确度调整
        if (imageData.length - targetSize < microAdjustment) {
            percent -= .02f; // 微调
        } else {
            percent -= .1f;
        }
        
        // 大小没有改变
        if (imageData.length == imageDatalength) {
            NSLog(@"压缩大小没有改变，需要调整图片尺寸");
            break;
        }
        imageDatalength = imageData.length;
    } while (imageData.length > targetSize+1024);/** 增加1k偏移量 */
    
    return imageData;
}

/** 快速压缩 压缩到大约指定体积大小(kb) 返回压缩后图片 */
- (UIImage *)np_fastestCompressImageWithSize:(CGFloat)size
{
    UIImage *compressedImage = [UIImage imageWithData:[self np_fastestCompressImageSize:size]];
    if (!compressedImage) {
        return self;
    }
    return compressedImage;
}

/** 快速压缩 压缩到大约指定体积大小(kb) 返回data */
- (NSData *)np_fastestCompressImageDataWithSize:(CGFloat)size
{
    return [self np_fastestCompressImageSize:size];
}

///压缩图片接口
- (NSData *)np_fastestCompressImageSize:(CGFloat)size
{
    /** 临时图片 */
    UIImage *compressedImage = self;
    CGFloat targetSize = size * 1024; // 压缩目标大小
    CGFloat percent = 0.5f; // 压缩系数
    if (size <= 10) {
        percent = 0.01;
    }
    /** 微调参数 */
    NSInteger microAdjustment = 5*1024;
    /** 设备分辨率 */
    
    CGSize pixel = [[UIScreen mainScreen] bounds].size;
    /** 缩放图片尺寸 */
    int MIN_UPLOAD_RESOLUTION = pixel.width * pixel.height;
    if (size < 100) {
        MIN_UPLOAD_RESOLUTION /= 2;
    }
    /** 缩放比例 */
    float factor;
    /** 当前图片尺寸 */
    float currentResolution = self.size.height * self.size.width;
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    
    /** 没有需要压缩的必要，直接返回 */
    if (imageData.length <= targetSize) return imageData;
    
    /** 缩放图片 */
    if (currentResolution > MIN_UPLOAD_RESOLUTION) {
        factor = sqrt(currentResolution / MIN_UPLOAD_RESOLUTION) * 2;
        compressedImage = [self np_scaleWithSize:CGSizeMake(self.size.width / factor, self.size.height / factor)];
    }
    
    /** 记录上一次的压缩大小 */
    NSInteger imageDatalength = 0;
    
    /** 压缩核心方法 */
    do {
        if (percent < 0.01) {
            /** 压缩系数不能少于0 */
            percent = 0.1f;
        }
        imageData = UIImageJPEGRepresentation(compressedImage, percent);
        
        //        NSLog(@"压缩后大小:%ldk, 压缩频率:%ldk", imageData.length/1024, (imageDatalength - imageData.length)/1024);
        // 压缩精确度调整
        if (imageData.length - targetSize < microAdjustment) {
            percent -= .02f; // 微调
        } else {
            percent -= .1f;
        }
        
        // 大小没有改变
        if (imageData.length == imageDatalength) {
            //            NSLog(@"压缩大小没有改变，需要调整图片尺寸");
            //            break;
            float scale = targetSize/(imageData.length-targetSize);
            /** 精准缩放计算误差值 */
            float gap = targetSize/(imageData.length/2-targetSize);
            gap = gap >= 1.0f || gap <= 0 ? 0.85f : gap;
            scale *= gap;
            if (scale >= 1.0f || scale <= 0) scale = 0.85f;
            compressedImage = [self np_scaleWithSize:CGSizeMake(compressedImage.size.width * scale, compressedImage.size.height * scale)];
        }
        imageDatalength = imageData.length;
    } while (imageData.length > targetSize+1024);/** 增加1k偏移量 */
    
    return imageData;
}

/// 缩放图片尺寸
- (UIImage*)np_scaleWithSize:(CGSize)newSize
{
    
    //We prepare a bitmap with the new size
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    
    //Draws a rect for the image
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    //We set the scaled image from the context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

///
- (NSData *)np_compressImageDataWithSize:(CGFloat)size
{
    NSData *data = [self np_compressImageSize:size];
    if (!data || data.length == 0) {
        return UIImageJPEGRepresentation(self, .9);
    }
    return data;
}

- (UIImage *)np_compressImageWithSize:(CGFloat)size
{
    /** 临时图片 */
    UIImage *compressedImage = [UIImage imageWithData:[self np_compressImageSize:size]];
    if (!compressedImage) {
        return self;
    }
    return compressedImage;
}

///图片压缩
- (NSData *)np_compressImageSize:(CGFloat)size
{
    CGFloat imageSize = UIImageJPEGRepresentation(self, 1).length;
    /** 临时图片 */
    UIImage *compressedImage = self;
    CGFloat targetSize = size * 1024; // 压缩目标大小
    NSData *data = [[NSData alloc]init];
    CGFloat compressImageWidth ; // 图片将要压缩的宽度
    CGFloat percent; // 压缩系数
    
    if (imageSize > targetSize) {
        if (compressedImage.size.width > 1136)
            compressImageWidth = 1136;
        else
            compressImageWidth = compressedImage.size.width;
        
        CGFloat scale = 0.95;
        
        // 尺寸压缩
        // compressedImage = [compressedImage imageCompressForTargetWidth:compressedImage.size.width * scale];
        
        // 质量压缩
        // data = [compressedImage compressImageWithPercent:percent targetSize:size];
        do {
            // 改变尺寸 ，再进行压缩（相同像素下图片质量相同）
            compressedImage = [compressedImage np_imageCompressForTargetWidth:compressImageWidth];
            
            // 返回图片质量都一样，只有高度不同 ，重设压缩系数
            if (compressedImage.size.width == 1136) {
                percent = .5;
            } else {
                percent = .3;
            }
            
            data = [compressedImage np_compressImageWithPercent:percent targetSize:size];
            compressImageWidth *= scale; // 改变宽高
            
        } while (data.length > targetSize);
    }
    return data;
}

/// 图片质量压缩
- (NSData *)np_compressImageWithPercent:(CGFloat)percent targetSize:(CGFloat)size
{
    // 压缩
    NSInteger targetLength = size * 1024;
    NSData *compressImageData = [[NSData alloc]init];
    NSData *comperData = [[NSData alloc]init]; // 用于比较data
    
    do {
        comperData = compressImageData;
        if (percent < 0) {
            percent = 0.001;
        }
        compressImageData = UIImageJPEGRepresentation(self, percent);
        
        // 压缩精确度调整
        if (compressImageData.length - targetLength < 50*1000) {
            percent -= .02; // 微调
        } else {
            percent -= .1;
        }
        
        // 大小没有改变
        if (comperData.length == compressImageData.length) {
            break;
        }
        
    } while (compressImageData.length >= targetLength);
    
    return compressImageData;
}

/// 图片尺寸压缩
- (UIImage *) np_imageCompressForTargetWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth + 1; /** 加1 是为了去掉float类型精度差导致图片压缩后白边问题*/
    thumbnailRect.size.height = scaledHeight + 1;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


//CGImageRef MyCreateThumbnailImageFromData (NSData * data, int imageSize)
//{
//    CGImageRef        myThumbnailImage = NULL;
//    CGImageSourceRef  myImageSource;
//    CFDictionaryRef   myOptions = NULL;
//    CFStringRef       myKeys[5];
//    CFTypeRef         myValues[5];
//    CFNumberRef       thumbnailSize;
//    
//    // Create an image source from NSData; no options.
//    myImageSource = CGImageSourceCreateWithData((CFDataRef)data,
//                                                NULL);
//    // Make sure the image source exists before continuing.
//    if (myImageSource == NULL){
//        fprintf(stderr, "Image source is NULL.");
//        return  NULL;
//    }
//    
//    // Package the integer as a  CFNumber object. Using CFTypes allows you
//    // to more easily create the options dictionary later.
//    thumbnailSize = CFNumberCreate(NULL, kCFNumberIntType, &imageSize);
//    
//    // Set up the thumbnail options.
//    myKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
//    myValues[0] = (CFTypeRef)kCFBooleanTrue;
//    myKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
//    myValues[1] = (CFTypeRef)kCFBooleanTrue;
//    myKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
//    myValues[2] = (CFTypeRef)thumbnailSize;
//    myKeys[3] = kCGImageSourceShouldCache;
//    myValues[3] = (CFTypeRef)kCFBooleanFalse;
//    myKeys[4] = kCGImageSourceShouldCacheImmediately;
//    myValues[4] = (CFTypeRef)kCFBooleanFalse;
//    
//    myOptions = CFDictionaryCreate(NULL, (const void **) myKeys,
//                                   (const void **) myValues, 2,
//                                   &kCFTypeDictionaryKeyCallBacks,
//                                   & kCFTypeDictionaryValueCallBacks);
//    
//    // Create the thumbnail image using the specified options.
//    myThumbnailImage = CGImageSourceCreateThumbnailAtIndex(myImageSource,
//                                                           0,
//                                                           myOptions);
//    // Release the options dictionary and the image source
//    // when you no longer need them.
//    CFRelease(thumbnailSize);
//    CFRelease(myOptions);
//    CFRelease(myImageSource);
//    
//    // Make sure the thumbnail image exists before continuing.
//    if (myThumbnailImage == NULL){
//        fprintf(stderr, "Thumbnail image not created from image source.");
//        return NULL;
//    }
//    
//    return myThumbnailImage;
//}

@end


#pragma mark -
#pragma mark - NPWater 水印
@implementation UIImage (NPWater)


- (UIImage *)waterWithText:(NSString *)text
                   direction:(NPImageWaterPosition)direction
                   fontColor:(UIColor *)fontColor
                   fontPoint:(CGFloat)fontPoint
                    marginXY:(CGPoint)marginXY
{
    CGSize size = self.size;
    CGRect rect = (CGRect){CGPointZero,size};
    //新建图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //绘制图片
    [self drawInRect:rect];
    
    //绘制文本
    NSDictionary *attr =@{NSFontAttributeName : [UIFont systemFontOfSize:fontPoint],NSForegroundColorAttributeName:fontColor};
    
    CGRect strRect = [self calWidth:text attr:attr direction:direction rect:rect marginXY:marginXY];
    
    [text drawInRect:strRect withAttributes:attr];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}


- (CGRect)calWidth:(NSString *)str attr:(NSDictionary *)attr direction:(NPImageWaterPosition)direction rect:(CGRect)rect marginXY:(CGPoint)marginXY{
    
    CGSize size =  [str sizeWithAttributes:attr];
    CGRect calRect = [self rectWithRect:rect size:size direction:direction marginXY:marginXY];
    return calRect;
}

- (CGRect)rectWithRect:(CGRect)rect size:(CGSize)size direction:(NPImageWaterPosition)direction marginXY:(CGPoint)marginXY{
    
    CGPoint point = CGPointZero;
    switch (direction) {
        case NPImageWaterPosition_TopLeft: {
            break;
        }
        case NPImageWaterPosition_TopRight: {
            point = CGPointMake(rect.size.width - size.width, 0);
            break;
        }
        case NPImageWaterPosition_BottomLeft: {
            point = CGPointMake(0, rect.size.height - size.height);
            break;
        }
        case NPImageWaterPosition_BottomRight: {
             point = CGPointMake(rect.size.width - size.width, rect.size.height - size.height);
            break;
        }
        case NPImageWaterPosition_Center: {
             point = CGPointMake((rect.size.width - size.width)*.5f, (rect.size.height - size.height)*.5f);
            break;
        }
    }
    
    point.x += marginXY.x;
    point.y += marginXY.y;
    CGRect calRect = (CGRect){point,size};
    return calRect;
}

- (UIImage *)waterWithWaterImage:(UIImage *)waterImage direction:(NPImageWaterPosition)direction waterSize:(CGSize)waterSize
                          marginXY:(CGPoint)marginXY{
    
    CGSize size = self.size;
    CGRect rect = (CGRect){CGPointZero,size};
    //新建图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //绘制图片
    [self drawInRect:rect];
    
    //计算水印的rect
    CGSize waterImageSize = CGSizeEqualToSize(waterSize, CGSizeZero)?waterImage.size:waterSize;
    CGRect calRect = [self rectWithRect:rect size:waterImageSize direction:direction marginXY:marginXY];
    
    //绘制水印图片
    [waterImage drawInRect:calRect];
    //获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
