//
//  QRData.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MasterpassQRCoreSDK;

@interface QRData : NSObject

@property NSString* merchantCode;
@property NSString* merchantName;
@property NSString* merchantCity;
@property NSString* merchantCountryCode;
@property NSString* merchantCategoryCode;
@property NSString* merchantIdentifierVisa02;
@property NSString* merchantIdentifierVisa03;
@property NSString* merchantIdentifierMastercard04;
@property NSString* merchantIdentifierMastercard05;
@property NSString* merchantIdentifierNPCI06;
@property NSString* merchantIdentifierNPCI07;
@property NSString* merchantStoreId;
@property NSString* merchantTerminalNumber;
@property NSString* merchantMobile;
@property double transactionAmount;
@property TipConvenienceIndicator tipType;
@property double tip;
@property NSString* currencyNumericCode;

@end
