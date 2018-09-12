//
//  UIBarButtonItem+NPExtension.h
//  Demo0801
//
//  Created by HzB on 16/8/5.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NPExtension)

+ (instancetype)np_itemWithImage:(UIImage *)image
                       target:(id)target
                       action:(SEL)action;

+ (instancetype)np_itemWithTitle:(NSString *)title
                       target:(id)target
                       action:(SEL)action;


- (void)np_setTitleColor:(UIColor *)titleColor
             forState:(UIControlState)state;

@end
