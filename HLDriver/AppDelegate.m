//
//  AppDelegate.m
//  HLDriver
//
//  Created by Admin on 2017/4/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "VehicleTypeViewController.h"
#import "BaseNavViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:[VehicleTypeViewController new]];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];

    
    
    return YES;
}







































- (void)applicationWillResignActive:(UIApplication *)application {
    }


- (void)applicationDidEnterBackground:(UIApplication *)application {
   }


- (void)applicationWillEnterForeground:(UIApplication *)application {
   }


- (void)applicationDidBecomeActive:(UIApplication *)application {
    }


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
