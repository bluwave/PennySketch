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

@interface BrowserViewController ()

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

    UILongPressGestureRecognizer *gest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleWebViewTap:)];

    gest.delegate = self;
    [self.view addGestureRecognizer:gest];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIWebView *) getWebView
{
    if ([self.viewControllers count] > 0)
    {
        SVWebViewController *svWebView = [self.viewControllers objectAtIndex:0];
        UIWebView *wv = (UIWebView *) svWebView.view;
        return wv;
    }
    return nil;
}


/*- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        CGPoint touchPoint = [touch locationInView:self.view];

        UIWebView *wv = [self getWebView];
        if (wv)
        {

            NSURL *url = [wv urlForImageAtPoint:touchPoint];
            if (url)
            {
                NSLog(@"%s ** should recieve touch",__func__);
                return YES;
            }


        }
    }
    return NO;
}*/


-(void) handleWebViewTap:(UITapGestureRecognizer *) g
{
    NSLog(@"%s ",__func__);

    CGPoint p =  [g locationInView:self.view];
    UIWebView * wv = [self getWebView];
    if(wv)
    {
        NSURL *url = [wv urlForImageAtPoint:p];
        if (url)
        {
            NSLog(@"%s url: %@",__func__, url);
            [self downloadImage:url];
        }
        else
        {
            NSLog(@"%s ** no image at point",__func__);
        }

    }



}

-(void) downloadImage:(NSURL *) url
{

    @synchronized (self)
    {

    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    AFImageRequestOperation * op = [AFImageRequestOperation imageRequestOperationWithRequest:req imageProcessingBlock:^UIImage *(UIImage *in)
    {
        @try
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:[url lastPathComponent]];
            NSData *data = UIImagePNGRepresentation(in);
            [data writeToFile:localFilePath atomically:YES];

        }
        @catch (NSException * ex)
        {
            NSLog(@"%s ex: %@", __func__, [ex description]);
        }
        @finally
        {
            NSLog(@"%s ** returning",__func__);
            return in;
        }
    }                                                 success:^(NSURLRequest *req0, NSURLResponse *resp, UIImage *img)
    {

    }                                                 failure:^(NSURLRequest *req1, NSURLResponse *resp, NSError *error)
    {
        [[[UIAlertView alloc] initWithTitle:nil message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];

    [op start];
    }
}

@end
