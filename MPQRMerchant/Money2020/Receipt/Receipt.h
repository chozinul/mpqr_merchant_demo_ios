//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class Transaction;
//@class PaymentData;

/**
 The class is for convenient for creating receipt
 Its informations is derived from transaction information and payment data
 */
@interface Receipt : NSObject

///Merchant name
@property NSString* _Nullable merchantName;
///Merchant city
@property NSString* _Nullable merchantCity;
///Transaction amount in currency
@property double transactionAmount;
///Tip amount in currency
@property double tipAmount;
///Total amount in currency
@property double totalAmount;
///Currency Code
@property NSString* _Nullable currencyCode;
///Masked pan / payment instrument identifier
@property NSString* _Nullable maskedPan;
///Method type
@property NSString* _Nullable methodType;
///Currency numberic code
@property NSString* _Nullable currencyNumericCode;
///Successfull transaction message, to be displayed under successful logo
@property NSString* _Nullable message;

///Initialize user object from Server Class RLMUser
//- (id _Nonnull) initWithTransaction:(Transaction* _Nonnull) transaction paymentData:(PaymentData* _Nonnull) paymentData;

@end
