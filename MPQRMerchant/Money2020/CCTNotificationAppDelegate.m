//
//  CCTAppDelegate.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "CCTNotificationAppDelegate.h"
#import "CCTNotificationTokenHandlerProtocol.h"
#import "CCTNotificationManager.h"
#import "CCTReceiptManager.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AppDelegate(CCTNotification)

/**
 If your app was running either in the foreground, or the background, application(_:didReceiveRemoteNotification:fetchCompletionHandler:) will be called. If the user opens the app by tapping the push notification, this method may be called again, so you can update the UI, and display relevant informatiAPNSon.
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    NSLog(userInfo.description,nil);
    
    NSString* notificationType = [userInfo objectForKey:@"notificationType"];
    if ([notificationType isEqualToString:kNotificationMerchantPresentedQRConsumerSendReceiptDetail]) {
        [[CCTReceiptManager sharedInstance] showDialogWithContex:self.window.rootViewController withParam:userInfo withYesBlock:^(ReceiptViewController* vc){} withNoBlock:^(ReceiptViewController* vc){}];
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Undefine Notification"
                                                                       message:userInfo.description
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];
        
        [alert addAction:defaultAction];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    AudioServicesPlaySystemSound(1103);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

/**
 Get device token for push notification.
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(deviceTokenString,nil);
    [CCTNotificationManager sharedInstance].deviceToken = deviceTokenString;
    [[CCTNotificationManager sharedInstance] registerTokenToServer:
     [CCTNotificationManager sharedInstance].deviceToken];
}

/**
 Failed when try to register and get device token.
 */
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(error.localizedDescription,nil);
}


@end
