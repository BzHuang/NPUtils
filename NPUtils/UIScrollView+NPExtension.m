//
//  UIScrollView+NPExtension.m
//  Demo0801
//
//  Created by HzB on 16/8/19.
//  Copyright © 2016年 HzB. All rights reserved.
//



#import "UIScrollView+NPExtension.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static NSString *ShowGoTopButtonKey = @"ShowGoTopButtonKey";
static NSString *GoTopButtonKey = @"GoTopButtonKey";

@implementation UIScrollView (NPExtension)

- (UIButton *)goTopButton{
    UIButton *button = objc_getAssociatedObject(self, &GoTopButtonKey);
    if (!button) {
       button = [self setupGoTopButton];
    }
    return button;
}

- (UIButton *)setupGoTopButton{
    
    UIButton *goTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goTopButton.backgroundColor = [UIColor grayColor];
    [goTopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [goTopButton addTarget:self action:@selector(goTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *superView = [self _viewController].view;
    [superView addSubview:goTopButton];
    
    // 添加 right 约束
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:goTopButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:0.0 constant:-20];
    [goTopButton addConstraint:rightConstraint];
    
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:goTopButton
                                                                        attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:40.0];
    [goTopButton addConstraint:heightConstraint];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:goTopButton
                                                                        attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:40.0];
    [goTopButton addConstraint:widthConstraint];
    
    // 添加 top 约束
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:goTopButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:0.0 constant:-40.0];
    [goTopButton addConstraint:bottomConstraint];

    objc_setAssociatedObject(self, &GoTopButtonKey, goTopButton, OBJC_ASSOCIATION_ASSIGN);
    return goTopButton;
}

- (void)goTopButtonAction:(UIButton *)button{
    [self setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)setShowGoTopButton:(BOOL)showGoTopButton{
    
    if (showGoTopButton == self.isShowGoTopButton) {
        return;
    }
    NSNumber *statu = [NSNumber numberWithBool:showGoTopButton];
    objc_setAssociatedObject(self, &ShowGoTopButtonKey, statu, OBJC_ASSOCIATION_ASSIGN);
    //
    if (showGoTopButton) {
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else{
        [self removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (BOOL)isShowGoTopButton{
    id statu = objc_getAssociatedObject(self, &ShowGoTopButtonKey);
    return [statu boolValue];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentOffset"]) {
        if (!self.isShowGoTopButton) {
            return;
        }
        if (self.contentOffset.y > 520.0) {
            self.goTopButton.hidden = NO;
        }else{
            self.goTopButton.hidden = YES;
        }
    }
}

- (UIViewController *)_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
