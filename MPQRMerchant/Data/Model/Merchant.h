//
//  Merchant.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Merchant : NSObject

@property NSString* name;
@property NSString* city;
@property NSString* categoryCode;
@property NSString* identifierVisa02;
@property NSString* identifierVisa03;
@property NSString* identifierMastercard04;
@property NSString* identifierMastercard05;
@property NSString* identifierNPCI06;
@property NSString* identifierNPCI07;
@property NSString* terminalNumber;
@property NSString* storeId;

@end
