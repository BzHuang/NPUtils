
//
//  NSMutableAttributedString+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "NSMutableAttributedString+NPExtension.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (NPExtension)

- (void)np_setColor:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound) {
        return;
    }
    [self addAttributes:@{NSForegroundColorAttributeName : color} range:range];
}

- (void)np_setColor:(UIColor *)color text:(NSString *)text{
    
    NSRange range = [self.mutableString rangeOfString:text];
    [self np_setColor:color range:range];
}

- (void)np_setFont:(UIFont *)font range:(NSRange)range{
    if (range.location == NSNotFound) {
        return;
    }
    [self addAttributes:@{NSFontAttributeName: font} range:range];
}

- (void)np_setFont:(UIFont *)font text:(NSString *)text{
    NSRange range = [self.mutableString rangeOfString:text];
    [self np_setFont:font range:range];
}

- (void)np_addLineText:(NSString *)text{
    //给this加上下划线，value可以在指定的枚举中选择
    NSRange range = [self.mutableString rangeOfString:text];
    [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                 value:(id)[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                 range:range];
}

- (void)np_setLineSpace:(CGFloat)space{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}


///首行缩进多少个字符
- (void)np_firstLineHeadIndent:(CGFloat)firstLineHeadIndent
                    fontOfSize:(CGFloat)fontOfSize;{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //首行缩进 (缩进个数 * 字号)
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent * fontOfSize;
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : [UIFont systemFontOfSize:fontOfSize],
                                   
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   };
    [self addAttributes:attributeDic range:NSMakeRange(0, self.length)];
}


@end
