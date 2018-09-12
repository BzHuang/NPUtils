//
//  UIViewController+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UIViewController+NPExtension.h"

@implementation UIViewController (NPExtension)

@end


#pragma mark -
#pragma mark - NPNavItem 导航栏按钮

@implementation UIViewController (NPNavItem)

- (UIBarButtonItem *)np_addLeftNavItemWithTitle:(NSString *)title{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftNavItemAction:)];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)np_addLeftNavItemWithImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [self np_addLeftNavItemWithImage:image];
}

- (UIBarButtonItem *)np_addLeftNavItemWithImage:(UIImage *)image{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftNavItemAction:)];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (void)leftNavItemAction:(UIBarButtonItem *)item{
}

#pragma mark -
- (UIBarButtonItem *)np_addRightNavItemWithTitle:(NSString *)title{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightNavItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)np_addRightNavItemWithImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [self np_addRightNavItemWithImage:image];
}

- (UIBarButtonItem *)np_addRightNavItemWithImage:(UIImage *)image{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rightNavItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    return item;
    
}

- (void)rightNavItemAction:(UIButton *)button{
}

#pragma mark -
- (UIBarButtonItem *)np_addGoBackLeftNavItem{
    return [self np_addLeftNavItemWithImageName:@"navi_back"];
}

- (void)np_goBackAnimated:(BOOL)animated{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:animated];
        }else{
            [self.navigationController dismissViewControllerAnimated:animated completion:nil];
        }
    }else{
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

@end

#pragma mark - NPKeyboard

@implementation UIViewController (NPKeyboard)

- (void)np_setupForDismissKeyboard {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(np_tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)np_tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

@end


