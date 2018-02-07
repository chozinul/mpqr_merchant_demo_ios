//
//  AppDelegate.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 2/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

/**
 This class is the first delegate class that application call when it is started.
 
 Once this delegate function is called, it will be redirected to MainViewController.
 */
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}



@end


