//
//  CCTFireBaseAppDelegate.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "CCTFireBaseAppDelegate.h"


@implementation AppDelegate(CCTFireBase)

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    
}

@end
