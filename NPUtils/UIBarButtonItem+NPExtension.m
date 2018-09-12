//
//  UIBarButtonItem+NPExtension.m
//  Demo0801
//
//  Created by HzB on 16/8/5.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UIBarButtonItem+NPExtension.h"

@implementation UIBarButtonItem (NPExtension)

+ (instancetype)np_itemWithImage:(UIImage *)image
                       target:(id)target
                       action:(SEL)action{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

+ (instancetype)np_itemWithTitle:(NSString *)title
                       target:(id)target
                       action:(SEL)action{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

- (void)np_setTitleColor:(UIColor *)titleColor
             forState:(UIControlState)state{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = titleColor;
    [self setTitleTextAttributes:normalAttrs forState:state];
}


@end
