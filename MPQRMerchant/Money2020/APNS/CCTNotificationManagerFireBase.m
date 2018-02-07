//
//  CCTNotificationTokenHandlerFireBase.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "CCTNotificationManagerFireBase.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
#import "CCTNotificationAppDelegate.h"
#import "CCTFireBaseAppDelegate.h"

@import AFNetworking;
@import Firebase;

@implementation CCTNotificationManagerFireBase

///Override function register token to firebase
- (void) registerTokenToServer: (NSString*) token{
    NSString* topic = [NSString stringWithFormat:@"%@",token];
    [[FIRMessaging messaging] subscribeToTopic:topic];
}


#pragma mark - Send Notification
- (void) sendNotificationToDevice:(NSString*) token{
    NSString *strURL = @"https://fcm.googleapis.com/";
    NSString *path = @"fcm/send";
    
    NSString* topic = [NSString stringWithFormat:@"/topics/qrb2p_%@",token];
    
    NSDictionary* notification = @{
                                   @"to" : topic,
                                   @"priority" : @"high",
                                   @"notification" : @{
                                           @"body" : @"so pretty This is a Firebase Cloud Messaging Topic Message!",
                                           @"title" : @"FCM Message"
                                           }
                                   };
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:strURL]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"key=AAAAsuhgtkA:APA91bH72tRrXvhBqA0grRtJvEJ8hx8SaV17QV9LykR4lTb5HFYQa28fuDSn94nzQygkSdZ8Bp5BjaV_vxJ_o7g8vXTR9dQDELyfM_5BToLJpJCjh7mC0erqP-q0LierczPfb7d06m56" forHTTPHeaderField:@"authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:path parameters:notification success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        //here is place for code executed in success case
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //here is place for code executed in error case
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error while sending POST"
                                                            message:@"Sorry, try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Configure
- (void) configureApp:(UIApplication* _Nonnull) application appDelegate:(AppDelegate* _Nonnull) delegate{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = delegate;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [application registerForRemoteNotifications];
    [FIRApp configure];
    [FIRMessaging messaging].delegate = delegate;
}

@end

