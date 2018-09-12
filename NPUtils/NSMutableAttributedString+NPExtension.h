//
//  NSMutableAttributedString+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (NPExtension)

///设置某个范围的颜色
- (void)np_setColor:(UIColor *)color
               range:(NSRange)range;

///设置某段文字的颜色
- (void)np_setColor:(UIColor *)color
               text:(NSString *)text;

///设置某个范围的字体
- (void)np_setFont:(UIFont *)font
             range:(NSRange)range;

/// 设置某段文字的字体
- (void)np_setFont:(UIFont *)font
              text:(NSString *)text;

/// 给某段文字添加下划线
- (void)np_addLineText:(NSString *)text;

///设置行距
- (void)np_setLineSpace:(CGFloat)space;

///首行缩进多少个字符
- (void)np_firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                 fontOfSize:(CGFloat)fontOfSize;

@end
