//
//  UITextField+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UITextField+NPExtension.h"

@implementation UITextField (NPExtension)

- (UIColor *)np_placeholderColor{
    return [self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setNp_placeholderColor:(UIColor *)np_placeholderColor{
    if (np_placeholderColor) {
        [self setValue:np_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (void)setNp_placeholderFont:(UIFont *)np_placeholderFont{
    if (np_placeholderFont) {
        [self setValue:np_placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
}

- (UIFont *)np_placeholderFont{
    return [self valueForKeyPath:@"_placeholderLabel.font"];
}

- (void)np_setLeftSpace:(CGFloat)leftSpace{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftSpace, 30)];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)np_setRightSpace:(CGFloat)rightSpace{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rightSpace, 30)];
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end

#pragma mark -
#pragma mark - NPNextendView

@implementation UITextField (NPNextendView)

#pragma mark - text
- (UILabel *)labelWithTitle:(NSString *)title
                       font:(UIFont*)font
                  textColor:(UIColor*)textColor{
    UILabel *label = [[UILabel alloc]init];
    if (font) {
        label.font = font;
    }else{
        label.font = self.font;
    }
    if (textColor) {
        label.textColor = textColor;
    }else{
        label.textColor = self.textColor;
    }
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (void)_sizeToFitNextendLabel:(UILabel *)label{
    CGFloat height = 30.0;
    CGFloat width = [label sizeThatFits:CGSizeMake(0, height)].width + 20.0;
    CGRect frame = label.frame;
    frame.size.width = width;
    label.frame = frame;
}

- (void)setNp_leftTitle:(NSString *)np_leftTitle{
    UILabel *label = self.np_leftLabel;
    if (!label) {
        label = [self labelWithTitle:np_leftTitle font:nil textColor:nil];
        self.np_leftLabel = label;
    }else{
        label.text = np_leftTitle;
    }
    [self _sizeToFitNextendLabel:label];
}

- (NSString *)np_leftTitle{
    return self.np_leftLabel.text;
}

- (void)setNp_leftLabel:(UILabel *)np_leftLabel{
    self.leftView = np_leftLabel;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (UILabel *)np_leftLabel{
    if ([self.leftView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.leftView;
        return label;
    }
    return nil;
}

- (void)setNp_rightTitle:(NSString *)np_rightTitle{
    UILabel *label = self.np_rightLabel;
    if (!label) {
        label = [self labelWithTitle:np_rightTitle font:nil textColor:nil];
        self.np_rightLabel = label;
    }else{
        label.text = np_rightTitle;
    }
    [self _sizeToFitNextendLabel:label];
}

- (NSString *)np_rightTitle{
    return self.np_rightLabel.text;
}

- (void)setNp_rightLabel:(UILabel *)np_rightLabel{
    self.rightView = np_rightLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UILabel *)np_rightLabel{
    if ([self.rightView isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self.rightView;
        return label;
    }
    return nil;
}

#pragma mark - image
- (UIImageView *)_npImageViewWithImage:(UIImage *)image{
    UIImageView *leftView = [[UIImageView alloc]initWithImage:image];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    return leftView;
}

- (void)_sizeToFitNextendImageView:(UIImageView *)imageView{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat height = imageView.image.size.height;
    CGFloat width = imageView.image.size.width + 20.0;
    imageView.frame = CGRectMake(x, y, width, height);
}


- (void)setNp_leftImage:(UIImage *)np_leftImage{
    UIImage *image = np_leftImage;
    UIImageView *imageView = self.np_leftImageView;
    if (!imageView) {
        imageView = [self _npImageViewWithImage:image];
        self.np_leftImageView = imageView;
    }else{
        imageView.image = image;
    }
    [self _sizeToFitNextendImageView:imageView];
}

- (UIImage *)np_leftImage{
    return self.np_leftImageView.image;
}

- (void)setNp_leftImageView:(UIImageView *)np_leftImageView{
    self.leftView = np_leftImageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (UIImageView *)np_leftImageView{
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self.leftView;
        return imageView;
    }
    return nil;
}

- (void)setNp_rightImage:(UIImage *)np_rightImage{
    UIImage *image = np_rightImage;
    UIImageView *imageView = self.np_rightImageView;
    if (!imageView) {
        imageView = [self _npImageViewWithImage:image];
        self.np_rightImageView = imageView;
    }else{
        imageView.image = image;
    }
    [self _sizeToFitNextendImageView:imageView];
}

- (UIImage *)np_rightImage{
    return self.np_rightImageView.image;
}

- (void)setNp_rightImageView:(UIImageView *)np_rightImageView{
    self.rightView = np_rightImageView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIImageView *)np_rightImageView{
    if ([self.rightView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self.rightView;
        return imageView;
    }
    return nil;
}

@end
