//
//  AppDelegate.h
//  PennySketch
//
//  Created by slim on 9/19/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class PSStackedViewController;

#define XAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) MainViewController *mainViewController;
@property (nonatomic, strong, readonly) PSStackedViewController *stackController;

@end
