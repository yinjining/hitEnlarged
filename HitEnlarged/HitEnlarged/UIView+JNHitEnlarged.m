#import "UIView+JNHitEnlarged.h"
#import <objc/runtime.h>

static char key_yjn_enlarged;

@implementation UIView (JNHitEnlarged)
@dynamic enlargeEdge;
@dynamic enlargedMargin;

-(void)setEnlargedMargin:(CGFloat)enlargedMargin{
    [self setEnlargeEdge:UIEdgeInsetsMake(enlargedMargin, enlargedMargin, enlargedMargin, enlargedMargin)];
}

-(void)setEnlargeEdge:(UIEdgeInsets)enlargeEdge{
    //拓展后的rect
    CGRect rect=CGRectMake(self.bounds.origin.x-enlargeEdge.left, self.bounds.origin.y-enlargeEdge.top, self.bounds.size.width+enlargeEdge.left+enlargeEdge.right, self.bounds.size.height+enlargeEdge.top+enlargeEdge.bottom);
    //存入
    objc_setAssociatedObject(self, &key_yjn_enlarged, @[NSStringFromCGRect(rect)], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //挣脱父试图束缚
    [self freeView:self.superview enlargeEdge:enlargeEdge];
}

-(NSArray *)enlargedRect{
    NSArray *enlargedArr = objc_getAssociatedObject(self, &key_yjn_enlarged);
    if (enlargedArr) {
        return enlargedArr;
    }else{
        return @[NSStringFromCGRect(self.bounds)];
    }
}
#pragma mark - 挣脱父试图束缚
-(void)freeView:(UIView *)superview  enlargeEdge:(UIEdgeInsets)enlargeEdge{
    if(superview == nil) return;
    
    CGRect selfEnlargeBounds = CGRectMake(self.bounds.origin.x-enlargeEdge.left, self.bounds.origin.y-enlargeEdge.top, self.bounds.size.width+enlargeEdge.left+enlargeEdge.right, self.bounds.size.height+enlargeEdge.top+enlargeEdge.bottom);

    //坐标转换
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect selfRect = [self convertRect:selfEnlargeBounds toView:window];
    CGRect superViewRect = [superview convertRect:superview.bounds toView:window];
    
    if (CGRectContainsRect(superViewRect,selfRect)) {//完全包含
        return;
    }else{//不完全包含
        NSMutableArray *rectArr = [NSMutableArray arrayWithArray:[superview enlargedRect]];
        
        CGRect newRect = CGRectMake(selfRect.origin.x - superViewRect.origin.x, selfRect.origin.y - superViewRect.origin.y, selfRect.size.width, selfRect.size.height);
        
        CGRect newEnlargeRect = CGRectMake(newRect.origin.x-enlargeEdge.left, newRect.origin.y-enlargeEdge.top, newRect.size.width+enlargeEdge.left+enlargeEdge.right, newRect.size.height+enlargeEdge.top+enlargeEdge.bottom);
        
        [rectArr addObject:NSStringFromCGRect(newEnlargeRect)];
        
        objc_setAssociatedObject(superview, &key_yjn_enlarged, rectArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self freeView:superview.superview enlargeEdge:enlargeEdge];
    }
}

#pragma mark - 响应者链
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    for (NSString *edgeStr in [self enlargedRect]) {
        CGRect rect= CGRectFromString(edgeStr);
        if (CGRectContainsPoint(rect,point)) {
            return YES;
        }
    }
    return NO;
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
