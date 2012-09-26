//
//  BrowserViewController.m
//  PennySketch
//
//  Created by slim on 9/20/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import "BrowserViewController.h"
#import "PSStackedViewGlobal.h"
#import "SVWebViewController.h"
#import "UIWebView+UIWebView_UrlExtractionUtils.h"
#import "AFNetworking.h"
#import "PSUtils.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"

#import <CommonCrypto/CommonDigest.h>


@interface BrowserViewController ()
@property(nonatomic, assign) TapDetectingWindow *mWindow;
@end

@implementation BrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.view.width = PSIsIpad() ? 600 : 150;
    self.view.backgroundColor = [UIColor redColor];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _mWindow = (TapDetectingWindow *) [[UIApplication sharedApplication].windows objectAtIndex:0];
    _mWindow.viewToObserve = [self getWebView];
    _mWindow.controllerThatObserves = self;

    NSLog(@"%s webView: %@", __func__, [self getWebView]);

}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s ",__func__);
    [super viewDidDisappear:animated];
    _mWindow.viewToObserve = nil;
    _mWindow.controllerThatObserves = nil;
    _mWindow = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (SVWebViewController *)svWebViewController
{
    if ([self.viewControllers count] > 0)
    {
        SVWebViewController *svWebView = [self.viewControllers objectAtIndex:0];
        return svWebView;
    }
    return nil;
}


- (UIWebView *)getWebView
{
    if ([self.viewControllers count] > 0)
    {
        SVWebViewController *svWebView = [self.viewControllers objectAtIndex:0];
        UIWebView *wv = (UIWebView *) svWebView.view;
        return wv;
    }
    return nil;
}


- (NSString *)convertUrlToFilename:(NSURL *)url
{
    const char *cStr = [[url absoluteString] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, strlen(cStr), result);

    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}


- (void)downloadImage:(NSURL *)url
{

    @synchronized (self)
    {

        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        AFImageRequestOperation *op = [AFImageRequestOperation imageRequestOperationWithRequest:req imageProcessingBlock:^UIImage *(UIImage *in)
        {
            @try
            {

                NSError *error = nil;

                [PSUtils createDataDirectory:&error];

                if (error)
                {
                    NSLog(@"%s ** error: %@", __func__, [error localizedDescription]);
                }
                else
                {
                    NSString *ext = [[[[url absoluteURL] path] pathExtension] lowercaseString];
                    NSString *filename = [NSString stringWithFormat:@"%@.%@", [self convertUrlToFilename:url], @"png"];
                    NSString *localFilePath = [[PSUtils dataDirectory] stringByAppendingPathComponent:filename];
                    NSData *data = UIImagePNGRepresentation(in);

                    [data writeToFile:localFilePath atomically:YES];
                }

            }
            @catch (NSException *ex)
            {
                NSLog(@"%s ex: %@", __func__, [ex description]);
            }
            @finally
            {
                NSLog(@"%s ** returning", __func__);
                return in;
            }
        }                                                                               success:^(NSURLRequest *req0, NSURLResponse *resp, UIImage *img)
        {

        }                                                                               failure:^(NSURLRequest *req1, NSURLResponse *resp, NSError *error)
        {
            [[[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];

        [op start];
    }
}

- (void)userDidTapWebView:(id)tapPoint
{

    NSArray * ptArr = (NSArray *)tapPoint;
    CGPoint p = CGPointZero;
    if ([ptArr count] == 2)
    {
         p = CGPointMake([ptArr[0] floatValue], [ptArr[1] floatValue]);
    }

    UIWebView *wv = [self getWebView];
    if (wv)
    {

        NSURL *url = [wv urlForImageAtPoint:p];
        if (url)
        {

            RIButtonItem * okBtn = [RIButtonItem item];
            okBtn.label = @"OK";
            okBtn.action = ^{
                [self downloadImage:url];
            };

            RIButtonItem *cancel = [RIButtonItem item];
            cancel.label = @"Cancel";


            [[[UIAlertView alloc] initWithTitle:@"Do you want to save this image?" message:nil cancelButtonItem:okBtn otherButtonItems:cancel, nil] show];

        }
        else
        {
//            NSLog(@"%s ** no image at point", __func__);
        }

    }
}

@end
