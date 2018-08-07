//
//  UIView+JNHitEnlarged.m
//  HitEnlarged
//
//  Created by yinjn on 2018/8/6.
//  Copyright © 2018年 殷继宁. All rights reserved.
//

#import "UIView+JNHitEnlarged.h"
#import <objc/runtime.h>
#include <objc/message.h>

static char key_yjn_enlarged;

@implementation UIView (JNHitEnlarged)
@dynamic enlargeEdge;
@dynamic enlargedMargin;

-(void)setEnlargedMargin:(CGFloat)enlargedMargin{
    [self setEnlargeEdge:UIEdgeInsetsMake(enlargedMargin, enlargedMargin, enlargedMargin, enlargedMargin)];
}

-(void)setEnlargeEdge:(UIEdgeInsets)enlargeEdge{
    objc_setAssociatedObject(self, &key_yjn_enlarged, NSStringFromUIEdgeInsets(enlargeEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGRect)enlargedRect{
    NSString *edgeStr=objc_getAssociatedObject(self, &key_yjn_enlarged);
    if (edgeStr) {
        UIEdgeInsets edgeInsets=UIEdgeInsetsFromString(edgeStr);
        CGRect enlargedrect=CGRectMake(self.bounds.origin.x-edgeInsets.left, self.bounds.origin.y-edgeInsets.top, self.frame.size.width+edgeInsets.left+edgeInsets.right, self.frame.size.height+edgeInsets.top+edgeInsets.bottom);
        return enlargedrect;
    }
    return self.bounds;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    if (CGRectContainsPoint(rect, point)) {
        return YES;
    }else{
        return NO;
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01){
        return nil;
    }
    
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO){        
        return nil;
    }
    
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
}
@end



