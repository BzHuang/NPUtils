//
//  UINavigationController+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/26.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NPExtension)

/**
 根据类从viewControllers 中找控制器

 @param controllerClass 控制器类
 @return 控制器
 */
- (UIViewController *)np_fineControllerOfClass:(Class)controllerClass;

- (BOOL)np_popToControllerClass:(Class)controllerClass
                       animated:(BOOL)animated;

@end
