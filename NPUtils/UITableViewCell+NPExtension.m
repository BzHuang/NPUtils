//
//  UITableViewCell+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UITableViewCell+NPExtension.h"

@implementation UITableViewCell (NPExtension)

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSAssert(NO, @"必须在cell实现该方法");
    return nil;
}

+ (CGFloat)cellHeight{
    return 44.0f;
}

@end
