//
//  UIView+NPExtension.m
//  ShareBey
//
//  Created by HzB on 16/7/21.
//  Copyright © 2016年 HzB. All rights reserved.
//

#import "UIView+NPExtension.h"


#pragma mark - NPFrame
@implementation UIView (NPFrame)

- (void)setLeft_np:(CGFloat)left_np{
    CGRect frame = self.frame;
    frame.origin.x = left_np;
    self.frame = frame;
}

- (CGFloat)left_np{
    return self.frame.origin.x;
}

- (void)setTop_np:(CGFloat)top_np{
    CGRect frame = self.frame;
    frame.origin.y = top_np;
    self.frame = frame;
}

- (CGFloat)top_np
{
    return self.frame.origin.y;
}


- (void)setWidth_np:(CGFloat)width_np
{
    CGRect frame = self.frame;
    frame.size.width = width_np;
    self.frame = frame;
}
- (CGFloat)width_np{
    return CGRectGetWidth(self.frame);
}

- (void)setHeight_np:(CGFloat)height_np
{
    CGRect frame = self.frame;
    frame.size.height = height_np;
    self.frame = frame;
}
- (CGFloat)height_np
{
    return self.frame.size.height;
}

- (void)setOrigin_np:(CGPoint)origin_np
{
    CGRect frame = self.frame;
    frame.origin = origin_np;
    self.frame = frame;
}
- (CGPoint)origin_np
{
    return self.frame.origin;
}


- (void)setSize_np:(CGSize)size_np
{
    CGRect frame = self.frame;
    frame.size = size_np;
    self.frame = frame;
}

- (CGSize)size_np
{
    return self.frame.size;
}


- (void)setCenterX_np:(CGFloat)centerX_np
{
    CGPoint center = self.center;
    center.x = centerX_np;
    self.center = center;
}
- (CGFloat)centerX_np
{
    return self.center.x;
}

- (void)setCenterY_np:(CGFloat)centerY_np
{
    CGPoint center = self.center;
    center.y = centerY_np;
    self.center = center;
}
- (CGFloat)centerY_np
{
    return self.center.y;
}

- (CGFloat)bottom_np
{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom_np:(CGFloat)bottom_np
{
    CGRect frame = self.frame;
    frame.origin.y = bottom_np - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right_np
{
    return CGRectGetMaxX(self.frame);
}

- (void)setRight_np:(CGFloat)right_np
{
    CGRect frame = self.frame;
    frame.origin.x = right_np - frame.size.width;
    self.frame = frame;
}

@end


#pragma mark -
#pragma mark - NPLine 线

#define NPLineViewColor    //分割线颜色
static const CGFloat NPLineViewHeight = 1.0; //横分隔线高度

@implementation UIView (NPLine)


- (UIView *)np_drawLineWithPosition:(NPLinePosition)position{
    return [self np_drawLineWithLeftSpace:0 rightSpace:0 position:position];
}

- (UIView *)np_drawLineWithLeftSpace:(CGFloat)leftSpace
                       rightSpace:(CGFloat)rightSpace
                         position:(NPLinePosition)position
{

//    UIView *lineView = [[UIView alloc]init];
//    lineView.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1];
//    [self addSubview:lineView];
//    __weak typeof(self) weakSelf = self;
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.mas_left).offset(leftSpace);
//        make.right.equalTo(weakSelf.mas_right).offset(-rightSpace);
//        make.height.equalTo(@(NPLineViewHeight));
//        if (position == NPLinePosition_Top) {
//            make.top.equalTo(weakSelf);
//        }else if (position == NPLinePosition_Bottom){
//            make.bottom.equalTo(weakSelf);
//        }
//    }];
    
    
    ////
//    lineView.translatesAutoresizingMaskIntoConstraints = NO;
//    // 添加 left 约束
//    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10];
//    [lineView addConstraint:leftConstraint];
//    
//    // 添加 right 约束
//    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:nil attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
//    [lineView addConstraint:rightConstraint];
//
//    // 添加 height 约束
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self
//                                                                        attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0];
//    [lineView addConstraint:heightConstraint];
//  
//    // 添加 top 约束
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
//    [lineView addConstraint:bottomConstraint];
    
    return lineView;
}

- (void)np_drawDashLineWithLength:(CGFloat)lineLength
                     lineSpace:(CGFloat)lineSpace
                     lineColor:(UIColor *)lineColor{
    UIView *lineView = self;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpace], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end

#pragma mark -
#pragma mark - NPCommon 常用的
@implementation UIView (NPCommon)

- (void)np_roundCut{
    self.layer.cornerRadius = self.frame.size.width / 2.0;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
}

- (UIViewController *)np_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end


@implementation UIView (NPAnimation)

+ (void)np_showOscillatoryAnimationWithLayer:(CALayer *)layer
                                        type:(NSInteger)type{
    
    NSNumber *animationScale1 = type == 0 ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == 0 ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end


@implementation UIView (subViews)

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}


@end

