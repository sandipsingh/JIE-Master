//
//  AppDelegate.h
//  JiE
//
//  Created by neeraj on 23/06/15.
//  Copyright (c) 2015 avigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <CoreData/CoreData.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "Request.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,RequestDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong,nonatomic) UINavigationController *localNavigationController123;
@property(strong,nonatomic) NSString *fId;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

