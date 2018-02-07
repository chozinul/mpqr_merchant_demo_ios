//
//  CCTNotificationTokenHandler.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTNotificationTokenHandlerProtocol.h"
#import "AppDelegate.h"

extern NSString *kNotificationMerchantPresentedQRConsumerSendReceiptDetail;

@interface CCTNotificationManager : NSObject <CCTNotificationTokenHandlerProtocol>

///Singleton object
+ (instancetype _Nonnull )sharedInstance;

///APNS Device Token
@property NSString* _Nonnull deviceToken;


- (void) configureApp:(UIApplication* _Nonnull) application appDelegate:(AppDelegate* _Nonnull) delegate;

- (void) sendNotificationToDevice:(NSString* _Nonnull) token;

@end
