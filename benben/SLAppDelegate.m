//
//  SLAppDelegate.m
//  benben
//
//  Created by Sonic Lin on 11/25/13.
//  Copyright (c) 2013 Sonic. All rights reserved.
//

#import "SLAppDelegate.h"
#import "AibangApi.h"
#import "SLMainViewController.h"

@implementation SLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [AibangApi setAppkey:@"de38e89398e88b2faae9c34804ea2b7c"];
    SLMainViewController *mainView=[[SLMainViewController alloc]initWithNibName:@"SLMainViewController" bundle:nil];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:mainView];
    if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=7.0) {
        navigationController.navigationBar.barTintColor=[UIColor colorWithRed:265/255.0 green:117/255.0 blue:147/255.0 alpha:1];
    }else{
        navigationController.navigationBar.tintColor=[UIColor colorWithRed:265/255.0 green:117/255.0 blue:147/255.0 alpha:1];
    }
    self.window.rootViewController=navigationController;
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    navigationController=nil;
    mainView=nil;
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
