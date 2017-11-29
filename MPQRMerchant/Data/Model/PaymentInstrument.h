//
//  PaymentInstrument.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>

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

//- (NSString*) getFormattedAmount;

@end
