//
//  UIViewController+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NPExtension)
@end

#pragma mark - 
#pragma mark - NPNavItem 导航栏按钮
@interface UIViewController (NPNavItem)

///导航栏添加左边按钮  默认响应 leftNavItemAction
- (UIBarButtonItem *)np_addLeftNavItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)np_addLeftNavItemWithImageName:(NSString *)imageName;
- (UIBarButtonItem *)np_addLeftNavItemWithImage:(UIImage *)image;
///左边导航itme 响应
- (void)leftNavItemAction:(UIBarButtonItem *)item;


///导航栏添加右边边按钮  默认响应 rightNavItemAction
- (UIBarButtonItem *)np_addRightNavItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)np_addRightNavItemWithImageName:(NSString *)imageName;
- (UIBarButtonItem *)np_addRightNavItemWithImage:(UIImage *)image;
///右边导航itme 响应
- (void)rightNavItemAction:(UIBarButtonItem *)item;

///添加一个常用的返回按钮
- (UIBarButtonItem *)np_addGoBackLeftNavItem;

///返回上一个页面
- (void)np_goBackAnimated:(BOOL)animated;

@end




#pragma mark - NPKeyboard
@interface UIViewController (NPKeyboard)
///点击收起键盘
- (void)np_setupForDismissKeyboard;

@end

