//
//  UIButton+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/22.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NPImagePosition
#pragma mark - NPImagePosition 图片位置
typedef NS_ENUM(NSInteger,NPImagePosition){
    NPImagePositionLeft = 0,              //图片在左，文字在右，默认
    NPImagePositionRight = 1,             //图片在右，文字在左
    NPImagePositionTop = 2,               //图片在上，文字在下
    NPImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (NPImagePosition)

/**
 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing

 @param postion 图片位置
 @param spacing 图片和文字的间隔
 */
- (void)np_setImagePosition:(NPImagePosition)postion
                spacing:(CGFloat)spacing;

@end;



#pragma mark -
#pragma mark - NPEnlargeEdge 增大按钮的点击范围
@interface UIButton (NPEnlargeEdge)

///增大按钮的点击范围
- (void)np_setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

@end

#pragma mark -
#pragma mark - NPExtension
@interface UIButton (NPExtension)


@end

