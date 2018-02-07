//
//  PaymentInstrument.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Payment transaction that belongs to the user.
 
 Payment instrument preference that will be stored in RLM database.
 */
@interface PaymentInstrument : RLMObject

@property long id;
@property NSString* acquirerName;
@property NSString* issuerName;
@property NSString* name;
@property NSString* methodType;
@property double balance;
@property NSString* maskedIdentifier;
@property NSString* currencyNumericCode;
@property BOOL isDefault;

@end
