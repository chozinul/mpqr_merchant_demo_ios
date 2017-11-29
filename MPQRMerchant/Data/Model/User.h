//
//  User.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>

@class PaymentInstrument;
@class Transaction;
RLM_ARRAY_TYPE(Transaction)
RLM_ARRAY_TYPE(PaymentInstrument)


@interface User : RLMObject

@property long id;
@property NSString* code;
@property NSString* name;
@property NSString* city;
@property NSString* categoryCode;
@property NSString* countryCode;
@property NSString* identifierVisa02;
@property NSString* identifierVisa03;
@property NSString* identifierMastercard04;
@property NSString* identifierMastercard05;
@property NSString* identifierNPCI06;
@property NSString* identifierNPCI07;
@property NSString* storeId;
@property NSString* terminalNumber;
@property NSString* currencyNumericCode;
@property NSString* mobile;
@property RLMArray<Transaction*><Transaction> *transactions;

@end
