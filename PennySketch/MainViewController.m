//
//  ExampleMenuRootController.m
//  PSStackedViewExample
//
//  Created by Peter Steinberger on 7/18/11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import "PSStackedView.h"
#import "AppDelegate.h"
#import "MenuTableViewCell.h"
//#import "ExampleMenuRootController.h"
#import "MainViewController.h"
//#import "ExampleViewController1.h"
//#import "ExampleViewController2.h"
#import "UIImage+OverlayColor.h"
#import "BrowserViewController.h"
#import "ImageGroupsViewController.h"

#include <QuartzCore/QuartzCore.h>

#define kMenuWidth 200
#define kCellText @"CellText"
#define kCellImage @"CellImage" 

@interface MainViewController()
@property (nonatomic, strong) UITableView *menuTable;
@property (nonatomic, strong) NSArray *cellContents;
@property (nonatomic, strong) UIImageView *popIconLeft;
@property (nonatomic, strong) UIImageView *popIconRight;
@end

@implementation MainViewController

@synthesize menuTable = menuTable_;
@synthesize cellContents = cellContents_;
@synthesize popIconLeft = popIconLeft_;
@synthesize popIconRight = popIconRight_;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject



///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"load example view, frame: %@", NSStringFromCGRect(self.view.frame));
        
#if 0
    self.view.layer.borderColor = [UIColor greenColor].CGColor;
    self.view.layer.borderWidth = 2.f;
#endif
    
    // add example background
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
            
    // prepare menu content

    self.cellContents = @[@{kCellText: @"View Images", kCellImage : [UIImage invertImageNamed:@"images2.png"]}, @{kCellText: @"Find Images", kCellImage : [UIImage invertImageNamed:@"search.png"]}];



    
    // add table menu
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMenuWidth, self.view.height) style:UITableViewStylePlain];
    self.menuTable = tableView;
    
    self.menuTable.backgroundColor = [UIColor clearColor];
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self.view addSubview:self.menuTable];
    [self.menuTable reloadData];
    
    self.popIconLeft = [[UIImageView alloc] initWithFrame:CGRectMake(225, 482, 50, 70)];
    self.popIconLeft.image = [UIImage imageNamed:@"popIcon.png"];
    self.popIconLeft.alpha = 0.0;
    [self.view addSubview:self.popIconLeft];
    
    self.popIconRight = [[UIImageView alloc] initWithFrame:CGRectMake(245, 502, 50, 70)];
    self.popIconRight.image = [UIImage imageNamed:@"popIcon.png"];
    self.popIconRight.alpha = 0.0;
    [self.view addSubview:self.popIconRight];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellContents_ count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExampleMenuCell";
    
    MenuTableViewCell *cell = (MenuTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellText];
	cell.imageView.image = [[cellContents_ objectAtIndex:indexPath.row] objectForKey:kCellImage];
	    

    return cell;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {  

    [XAppDelegate.stackController popToRootViewControllerAnimated:YES];

    if (indexPath.row == 0)
    {
        ImageGroupsViewController *imageGroupsVC = [[ImageGroupsViewController alloc] init];
        [XAppDelegate.stackController pushViewController:imageGroupsVC fromViewController:nil animated:YES];

    }

    if (indexPath.row == 1)
    {

        BrowserViewController *brwsr = [[BrowserViewController alloc] initWithAddress:@"http://www.google.com"];
//        BrowserViewController * brwsr = [[BrowserViewController alloc] initWithAddress:@"http://abduzeedo.com/cool-illustrated-facial-expressions"];

        [XAppDelegate.stackController pushViewController:brwsr fromViewController:nil animated:YES];

    }
}

/// PSStackedViewDelegate methods

- (void)stackedViewDidStartDragging:(PSStackedViewController *)stackedView {
    if([stackedView.viewControllers count] > 1) {
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.popIconLeft.alpha = 1.0;
            self.popIconRight.alpha = 1.0;
        }];
    }
}

- (void)stackedViewDidStopDragging:(PSStackedViewController *)stackedView {
    [UIView animateWithDuration:0.2 animations:^(void) {
        self.popIconLeft.alpha = 0.0;
        self.popIconRight.alpha = 0.0;
        self.popIconRight.transform = CGAffineTransformIdentity;
    }];
}

-(void)stackedView:(PSStackedViewController *)stackedView WillPopViewControllers:(NSArray *)controllers {
    if([controllers count] > 0) {
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.popIconRight.alpha = 0.5;
            CGAffineTransform trans = CGAffineTransformMakeTranslation(40, 10);
            trans = CGAffineTransformRotate(trans, M_PI/4);
            self.popIconRight.transform = trans;
        }];
    }
}

- (void)stackedView:(PSStackedViewController *)stackedView WillNotPopViewControllers:(NSArray *)controllers {
    if([controllers count] > 0) {
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.popIconRight.alpha = 1.0;
            self.popIconRight.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
