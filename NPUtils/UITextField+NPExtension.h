//
//  UITextField+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NPExtension)

///水印字体颜色 要先设置Placeholder才有效
@property (nonatomic,strong) UIColor *np_placeholderColor;

///水印字体 要先设置Placeholder才有效
@property (nonatomic,strong) UIFont *np_placeholderFont;

///左边的间距
- (void)np_setLeftSpace:(CGFloat)leftSpace;

///设置右边的间距
- (void)np_setRightSpace:(CGFloat)rightSpace;

@end

#pragma mark -
#pragma mark - NPNextendView
@interface UITextField (NPNextendView)

///左边标题
@property (nonatomic,copy) NSString *np_leftTitle;
///右边标题
@property (nonatomic,copy) NSString *np_rightTitle;

@property (nonatomic,strong) UILabel *np_leftLabel;

@property (nonatomic,strong) UILabel *np_rightLabel;

///左边图片
@property (nonatomic,strong) UIImage *np_leftImage;
///右边图片
@property (nonatomic,strong) UIImage *np_rightImage;

@property (nonatomic,strong) UIImageView *np_leftImageView;

@property (nonatomic,strong) UIImageView *np_rightImageView;


@end
