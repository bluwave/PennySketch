//
//  ImageGroupsViewController.m
//  PennySketch
//
//  Created by slim on 9/21/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import "ImageGroupsViewController.h"
#import "PSUtils.h"
#import "PSStackedViewController.h"
#import "AppDelegate.h"
#import "ImageViewController.h"
#import "ImageGroupCell.h"

@interface ImageGroupsViewController ()
@property(nonatomic, retain) NSMutableArray *images;


@end

@implementation ImageGroupsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.images = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] subpathsOfDirectoryAtPath:[PSUtils dataDirectory] error:nil]];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_images count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ImageGroupCell *cell = (ImageGroupCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[ImageGroupCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }


    NSString *path = [[PSUtils dataDirectory] stringByAppendingPathComponent:[_images objectAtIndex:indexPath.row]];
    NSError *err = nil;
    NSData *data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&err];
    if (!err)
    {
        UIImage *img = [UIImage imageWithData:data];
        [cell setImage:img];

    }
    else
        cell.textLabel.text = [err localizedDescription];


    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *vc = nil;

    UIViewController *last = [XAppDelegate.stackController.viewControllers lastObject];
    if ([last isKindOfClass:[ImageViewController class]])
    {
        vc = (ImageViewController *) last;
        vc.image = ((ImageGroupCell *)[tableView cellForRowAtIndexPath:indexPath]).image;
    }
    else
    {
        vc = [[ImageViewController alloc] init];
        vc.image =((ImageGroupCell *)[tableView cellForRowAtIndexPath:indexPath]).image;
        [XAppDelegate.stackController pushViewController:vc fromViewController:nil animated:YES];
    }


}

@end
