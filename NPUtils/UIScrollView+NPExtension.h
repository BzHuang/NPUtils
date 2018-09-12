//
//  UIScrollView+NPExtension.h
//  Demo0801
//
//  Created by HzB on 16/8/19.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (NPExtension)

///是否显示返回顶部按钮
@property (nonatomic, assign,getter=isShowGoTopButton) BOOL showGoTopButton;
@property (nonatomic, strong,readonly) UIButton *goTopButton;

@end
