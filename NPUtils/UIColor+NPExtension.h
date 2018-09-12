//
//  UIColor+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NPExtension)

///根据rgb生成颜色
+ (instancetype)np_colorWithRGB:(CGFloat)R
                           G:(CGFloat)G
                           B:(CGFloat) B;

+ (instancetype)np_colorWithRGB:(CGFloat)R
                        G:(CGFloat)G
                        B:(CGFloat) B
                        alpha:(CGFloat)alpha;

///将16进制颜色编码 字符串转为颜色
+ (instancetype)np_colorWithHexString:(NSString *)color;

+ (instancetype)np_colorWithHexString:(NSString *)color
                             alpha:(CGFloat)alpha;


///随机颜
+ (UIColor *)np_randomColor;

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)np_gradientFromColor:(UIColor*)c1
                         toColor:(UIColor*)c2
                          height:(int)height;

@end
