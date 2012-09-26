//
//  TapDetectingWindow.h
//  PennySketch
//
//  Created by slim on 9/25/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapDetectingWindowDelegate
- (void)userDidTapWebView:(id)tapPoint;
@end
@interface TapDetectingWindow : UIWindow {

}
@property (nonatomic, retain) UIView *viewToObserve;
@property (nonatomic, assign) id <TapDetectingWindowDelegate> controllerThatObserves;
@end
