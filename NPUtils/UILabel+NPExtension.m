//
//  UILabel+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UILabel+NPExtension.h"

@implementation UILabel (NPExtension)

@end

#pragma mark -
#pragma mark - NPSize
@implementation UILabel (NPSize)

- (CGFloat)np_heightForWidth:(CGFloat)width{
    if (width == 0) {
        width = CGRectGetWidth(self.frame);
    }
    if (width == 0) {
        width = 10000;
    }
    return [self sizeThatFits:CGSizeMake(width, 0)].height;
}

- (CGFloat)np_widthForHeight:(CGFloat)height{
    if (height == 0) {
        height = CGRectGetHeight(self.frame);
    }
    if (height == 0) {
        height = 10000;
    }
    return [self sizeThatFits:CGSizeMake(0, height)].width;
}


@end
