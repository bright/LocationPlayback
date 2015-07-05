#import "UIView+Additions.h"


@implementation UIView (Additions)
- (void)addRemovalFromSuperviewGesture:(UIGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer addTarget:self action:@selector(removeFromSuperviewAction)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)addMoveGesture:(UIGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer addTarget:self action:@selector(move:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)removeFromSuperviewAction {
    [self removeFromSuperview];
}

- (void)move:(UIPanGestureRecognizer *)sender {
    self.center = [sender locationInView:self.superview];
}

@end