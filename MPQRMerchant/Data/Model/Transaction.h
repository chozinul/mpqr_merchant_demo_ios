//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>

@import MasterpassQRCoreSDK;

@interface Transaction : RLMObject

@property NSString* referenceId;
@property NSString* invoiceNumber;
@property double transactionAmount;
@property double tipAmount;
@property NSString* currencyNumericCode;
@property NSDate* transactionDate;
@property NSString* terminalNumber;
@property NSString* merchantName;//na
@property long instrumentIdentifier;//na
@property NSString* maskedIdentifier;//na

- (CurrencyEnum) getCurrencyCode;
- (NSString*) getFormattedTransactionDate;
@end
