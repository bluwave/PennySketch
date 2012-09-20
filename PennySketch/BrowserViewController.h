//
//  BrowserViewController.h
//  PennySketch
//
//  Created by slim on 9/20/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSStackedViewDelegate.h"
#import "SVWebViewController.h"

@class SVWebViewController;

@interface BrowserViewController : SVModalWebViewController  <PSStackedViewDelegate,UIGestureRecognizerDelegate>


@end
