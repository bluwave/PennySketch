#import "TapDetectingWindow.h"

@implementation TapDetectingWindow
@synthesize viewToObserve;
@synthesize controllerThatObserves;

- (id)initWithViewToObserver:(UIView *)view andDelegate:(id)delegate
{
    if (self == [super init])
    {
        self.viewToObserve = view;
        self.controllerThatObserves = delegate;
    }
    return self;
}


- (void)forwardTap:(id)touch
{
    [controllerThatObserves userDidTapWebView:touch];
}

- (void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    if (viewToObserve == nil || controllerThatObserves == nil)
        return;
    NSSet *touches = [event allTouches];
    if (touches.count != 2)
        return;

    UITouch *touch = touches.anyObject;
    if (touch.phase != UITouchPhaseEnded)
        return;
//    if ([touch.view isDescendantOfView:viewToObserve] == NO)
//        return;
    CGPoint locInWindow = [touch locationInView:self];
    NSLog(@"%s locInWindow: %@",__func__, NSStringFromCGPoint(locInWindow));

    CGPoint tapPoint = [touch locationInView:viewToObserve];
    NSLog(@"TapPoint = %f, %f", tapPoint.x, tapPoint.y);
//    NSArray *pointArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", tapPoint.x],
//                                                    [NSString stringWithFormat:@"%f", tapPoint.y], nil];
//
    NSArray *pointArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", locInWindow.x],
                                                        [NSString stringWithFormat:@"%f", locInWindow.y], nil];
    if (touch.tapCount == 1)
    {
        [self performSelector:@selector(forwardTap:) withObject:pointArray afterDelay:0.5];
    }
    else if (touch.tapCount > 1)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(forwardTap:) object:pointArray];
    }
}
@end