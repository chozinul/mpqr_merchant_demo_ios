//
//  Transaction.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Transaction;
@class PaymentData;

@interface Receipt : NSObject

@property NSString* _Nullable merchantName;
@property NSString* _Nullable merchantCity;
@property double transactionAmount;
@property double tipAmount;
@property double totalAmount;
@property NSString* _Nullable currencyCode;
@property NSString* _Nullable maskedPan;
@property NSString* _Nullable methodType;

- (id _Nonnull) initWithTransaction:(Transaction* _Nonnull) transaction paymentData:(PaymentData* _Nonnull) paymentData;

@end
