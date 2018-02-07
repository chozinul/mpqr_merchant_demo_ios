//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

@import MasterpassQRCoreSDK;

/**
 Sample transaction for display and can be access from main page.
 
 Sample transaction that will be stored in RLM database.
 */
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
