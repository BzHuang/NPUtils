//
//  UITableViewHeaderFooterView+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (NPExtension)

+ (CGFloat)viewHeight;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end
