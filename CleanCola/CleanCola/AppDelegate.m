//
//  AppDelegate.m
//  CleanCola
//
//  Created by Marvin on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // Initialize RestKit
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://api.cleancola.org"]];
    
    RKObjectMapping *postObjectMapping = [RKObjectMapping requestMapping];
    [postObjectMapping addAttributeMappingsFromDictionary:@{
     @"description": @"description",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"category_id": @"category_id",
     @"incident_id": @"id",
     @"title": @"title",
     @"date_created" :@"date_created",
     @"is_flagged": @"is_flagged",
     @"is_closed": @"is_closed",
     @"votes":@"votes"
     }];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:postObjectMapping
                                                                                   objectClass:[Incident class] rootKeyPath:nil];
    
    [[RKObjectManager sharedManager] addRequestDescriptor: requestDescriptor];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:postObjectMapping pathPattern:nil keyPath:@"incidents" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    
    RKObjectMapping* incidentMapping = [RKObjectMapping mappingForClass:[Incident class]];
    [incidentMapping addAttributeMappingsFromDictionary:@{
     @"date_created": @"date_created",
     @"title" : @"title",
     @"description": @"description",
     @"id": @"incident_id",
     @"category_id" : @"category_id",
     @"date_created" : @"date_created",
     @"votes" : @"votes",
     @"is_closed" : @"is_closed",
     @"is_flagged" : @"is_flagged",
     @"votes" :@"votes",
     @"latitude": @"latitude",
     @"longitude": @"longitude"
     }];
    
    RKResponseDescriptor *responseDescriptor3 = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:@"/incidents" keyPath:@"incident" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor3];
    
//    RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore defaultStore];
//    objectManager.managedObjectStore = managedObjectStore;
//    
//    [RKObjectManager setSharedManager:objectManager];
//    
//    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"incidents" inManagedObjectStore:managedObjectStore];
//    [entityMapping addAttributeMappingsFromDictionary:@{
//     @"date_created": @"date_created",
//     @"description": @"description",
//     @"incident_id": @"incident_id",
//     @"latitude": @"latitude",
//     @"longitude": @"longitude"}];
//    
//    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping pathPattern:@"/incidents" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    
//    [objectManager addResponseDescriptor:responseDescriptor];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
