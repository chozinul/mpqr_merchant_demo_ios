//
//  CCTNotificationTokenHandler.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 29/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCTNotificationTokenHandlerProtocol<NSObject>

@required
- (void) registerTokenToServer: (NSString*) token;

@optional

@end
