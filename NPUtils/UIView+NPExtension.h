//
//  UIView+NPExtension.h
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - NPFrame x，y，width，height等
/**
 *  获取，设置view的x，y，width，height 等
 */
@interface UIView (NPFrame)

@property (nonatomic, assign) CGFloat left_np;
@property (nonatomic, assign) CGFloat top_np;
@property (nonatomic, assign) CGFloat width_np;
@property (nonatomic, assign) CGFloat height_np;
@property (nonatomic, assign) CGPoint origin_np;
@property (nonatomic, assign) CGSize  size_np;
@property (nonatomic, assign) CGFloat centerX_np;
@property (nonatomic, assign) CGFloat centerY_np;
@property (nonatomic, assign) CGFloat right_np;
@property (nonatomic, assign) CGFloat bottom_np;

@end

#pragma mark -
#pragma mark - NPLine 线
typedef NS_ENUM(NSInteger,NPLinePosition){
    NPLinePosition_Top,
    NPLinePosition_Bottom,
};

@interface UIView (NPLine)

/**
 给view添加一条线

 @param position 位置
 @return lineView
 */
//- (UIView *)np_drawLineWithPosition:(NPLinePosition)position;


/**
 给view添加一条线

 @param leftSpace 左边的距离
 @param rightSpace 右边的距离
 @param position 位置
 @return lineView
 */
- (UIView *)np_drawLineWithLeftSpace:(CGFloat)leftSpace
                             rightSpace:(CGFloat)rightSpace
                               position:(NPLinePosition)position;
/**
 给view画虚线

 @param lineLength 虚线长
 @param lineSpace 虚线间的间距
 @param lineColor 虚线颜色
 */
- (void)np_drawDashLineWithLength:(CGFloat)lineLength
         lineSpace:(CGFloat)lineSpace
           lineColor:(UIColor *)lineColor;

@end


#pragma mark -
#pragma mark - NPCommon 
@interface UIView (NPCommon)

///圆形
- (void)np_roundCut;

///找到自己的vc
- (UIViewController *)np_viewController;

@end


@interface UIView (NPAnimation)

///0 放大 1 缩小
+ (void)np_showOscillatoryAnimationWithLayer:(CALayer *)layer
                                        type:(NSInteger)type;

@end


@interface UIView (subViews)

- (UIView *)subViewOfClassName:(NSString*)className;

@end


