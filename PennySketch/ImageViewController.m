//
//  ImageViewController.m
//  PennySketch
//
//  Created by slim on 9/25/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property(nonatomic, retain) UIImageView *imageView;
@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    self.imageView = [[UIImageView alloc] initWithImage:self.image];

    [self.view addSubview:_imageView];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    if (_imageView)                  {
        [_imageView setImage:_image];
        [_imageView sizeToFit];
    }

}

@end
