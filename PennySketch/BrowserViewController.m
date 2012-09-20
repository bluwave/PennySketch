//
//  BrowserViewController.m
//  PennySketch
//
//  Created by slim on 9/20/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import "BrowserViewController.h"
#import "PSStackedViewGlobal.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

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
    self.view.width = PSIsIpad() ? 600 : 150;
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
