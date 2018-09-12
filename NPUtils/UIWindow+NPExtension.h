//
//  UIWindow+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (NPExtension)


/**
 获取最上层的UIViewController

 @return 最上层的UIViewController
 */
+ (UIViewController *)np_topViewController;


/**
 获取当前的UIWindow

 @return 当前使用的UIWindow
 */
+ (UIWindow *)np_currentWindow;


@end
