//
//  CCTNotificationTokenHandler.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "CCTNotificationManager.h"
#import "CCTNotificationManagerFireBase.h"

NSString *kNotificationMerchantPresentedQRConsumerSendReceiptDetail= @"kNotificationMerchantPresentedQRConsumerSendReceiptDetail";

@implementation CCTNotificationManager

///Singleton object
+ (instancetype _Nonnull)sharedInstance
{
    static CCTNotificationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCTNotificationManagerFireBase alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

#pragma mark - Notification Handler Protocol
- (void) registerTokenToServer: (NSString*) token{}

#pragma mark - Configure
- (void) configureApp:(UIApplication* _Nonnull) application appDelegate:(AppDelegate* _Nonnull) delegate{}

#pragma mark - Send Notification
- (void) sendNotificationToDevice:(NSString* _Nonnull) token{}
@end
