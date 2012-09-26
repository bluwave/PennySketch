//
//  UIWebView+UIWebView_UrlExtractionUtils.m
//  PennySketch
//
//  Created by slim on 9/20/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import "UIWebView+UIWebView_UrlExtractionUtils.h"

@implementation UIWebView (UIWebView_UrlExtractionUtils)

- (NSURL *)urlForImageAtPoint:(CGPoint)point
{
    NSLog(@"%s using point: %@",__func__, NSStringFromCGPoint(point));
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", point.x, point.y];
    NSString *urlToSave = [self stringByEvaluatingJavaScriptFromString:imgURL];
//    NSLog(@"%s url: %@", __func__, urlToSave);

    NSURL *imageURL = [NSURL URLWithString:urlToSave];
    if (imageURL && imageURL.scheme && imageURL.host)
    {
        // candidate is a well-formed url with:
        return imageURL;
    }
    return nil;
}
@end
