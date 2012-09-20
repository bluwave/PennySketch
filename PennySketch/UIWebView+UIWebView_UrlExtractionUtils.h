//
//  UIWebView+UIWebView_UrlExtractionUtils.h
//  PennySketch
//
//  Created by slim on 9/20/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (UIWebView_UrlExtractionUtils)
- (NSURL *)urlForImageAtPoint:(CGPoint)point;
@end
