//
//  UINavigationController+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/26.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UINavigationController+NPExtension.h"

@implementation UINavigationController (NPExtension)

- (UIViewController *)np_fineControllerOfClass:(Class)controllerClass
{
        UIViewController *controller = nil;
        for(UIViewController *subController in self.viewControllers){
            if([subController isKindOfClass:controllerClass]){
                controller = subController;
                break;
            }
        }
        return controller;
}

- (BOOL)np_popToControllerClass:(Class)controllerClass animated:(BOOL)animated{
    
    UIViewController *popVC = [self np_fineControllerOfClass:controllerClass];
    if (!popVC) {
        return NO;
    }
     [self popToViewController:popVC animated:animated];
    return YES;
}

@end
