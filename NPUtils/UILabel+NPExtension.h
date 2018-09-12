//
//  UILabel+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NPExtension)

@end

#pragma mark - 
#pragma mark - NPSize
@interface UILabel (NPSize)

- (CGFloat)np_heightForWidth:(CGFloat)width;

- (CGFloat)np_widthForHeight:(CGFloat)height;
@end
