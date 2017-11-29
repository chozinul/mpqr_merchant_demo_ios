//
//  PaymentData.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MasterpassQRCoreSDK;

@class Merchant;
@interface PaymentData : NSObject

@property  long userId;
@property  long cardId;
@property  BOOL isDynamic;
@property  double transactionAmount;
@property  TipConvenienceIndicator tipType;
@property  double tip;
@property  NSString* currencyNumericCode;
@property  NSString* mobile;
@property  Merchant* merchant;

- (double) getTipAmount;

@end
