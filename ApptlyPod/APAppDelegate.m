//
//  AppDelegate.m
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import "APAppDelegate.h"
#import "APIManager.h"
#import "APSideMenuViewController.h"
#import "CenterViewController.h"
#import <AWSSNS.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <Crashlytics/Crashlytics.h>

@interface APAppDelegate ()

@end

@implementation APAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withRootViewController:(CenterViewController *)viewController {
    
    APIManager *projectSettings = [[APIManager sharedManager] initFromPlist];
    [projectSettings populateCoreData:self.managedObjectContext withCompletion:^(BOOL completion) {
        if (completion) {
            [[APIManager sharedManager] requestAppData:self.managedObjectContext];
            [self setUpDrawerController:viewController];
            
                [self checkForTwitter];
                
                [self setUpGooglePlus];
        }
    }];
    
    
    AWSStaticCredentialsProvider *credentialsProvider = [[AWSStaticCredentialsProvider alloc] initWithAccessKey:@"AKIAIWP6JCHRY25UQ2DA" secretKey:@"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"];
    
    AWSServiceConfiguration *defaultServiceConfiguration = [[AWSServiceConfiguration alloc]
                                                            initWithRegion:AWSRegionUSWest2 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = defaultServiceConfiguration;
    
#if DEBUG
    [[APIManager sharedManager] setNotification:@{@"aps":@{@"alert":@"This is a test push notif"}} withManagedObjectContext:self.managedObjectContext];
#endif
    
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkForAndInitializeSocialAccounts)
                                                 name:@"coreDataUpdated" object:nil];
    
    [Fabric with:@[CrashlyticsKit]];
    
    return YES;
}

- (void) setUpDrawerController:(CenterViewController *)viewController {
    
    BOOL hasSocialAccounts = [[APIManager sharedManager] projectHasSocialAccounts];
    
    APSideMenuViewController *leftDrawer = [[APSideMenuViewController alloc] init];
    CenterViewController *mainVC = viewController == nil ?
        [[CenterViewController alloc] init] : viewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    if (hasSocialAccounts) {
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftDrawer];
        
        [mainVC setRightNavigationItem];
        
    }else {
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:leftDrawer];
    }
    
    self.drawerController.maximumLeftDrawerWidth = [leftDrawer returnWidthForMenuViewController];
    
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.drawerController.shouldStretchDrawer = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window setRootViewController:self.drawerController];
}

- (void)checkForAndInitializeSocialAccounts {
    [self checkForTwitter];
    [self setUpGooglePlus];
}

- (void)checkForTwitter {
    
    BOOL hasTwitter = [[APIManager sharedManager] siteHasSocialAccount:TWIITER withMoc:self.managedObjectContext];
    
    if (hasTwitter) {
        [[Twitter sharedInstance] startWithConsumerKey:@"lvxOObQTS9IZZu3ta9mRFRtsG" consumerSecret:@"JjNYcpN5eTnIiRxxc9IMfrF9X6yEgubCsNotQWfr6fkdoJnSKj"];
        [Fabric with:@[[Twitter sharedInstance]]];
    }
    
#if DEBUG
    [[Twitter sharedInstance] startWithConsumerKey:@"lvxOObQTS9IZZu3ta9mRFRtsG" consumerSecret:@"JjNYcpN5eTnIiRxxc9IMfrF9X6yEgubCsNotQWfr6fkdoJnSKj"];
    [Fabric with:@[[Twitter sharedInstance]]];
#endif
}


- (void) setUpGooglePlus {
    
    BOOL hasGooglePlus = [[APIManager sharedManager] siteHasSocialAccount:GOOGLEPLUS withMoc:self.managedObjectContext];
    
    if (hasGooglePlus) {
        
        [GPPSignIn sharedInstance].clientID = [[APIManager sharedManager] fetchSocialItem:GOOGLEPLUS withProperty:@"accountId"];
        
        [GPPDeepLink setDelegate:self];
        
        [GPPDeepLink readDeepLinkAfterInstall];
    }
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.richmondwatkins.ApptlyPod" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ApptlyPod" withExtension:@"momd"];
   
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ApptlyPod.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
