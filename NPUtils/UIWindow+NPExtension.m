//
//  UIWindow+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UIWindow+NPExtension.h"

@implementation UIWindow (NPExtension)

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

- (UIViewController *)np_topViewController{
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

#pragma mark -
+ (UIViewController *)np_topViewController{
    return [[self np_currentWindow] np_topViewController];
}

+ (UIWindow *)np_currentWindow{
    return [[[UIApplication sharedApplication] delegate] window];
}


@end
