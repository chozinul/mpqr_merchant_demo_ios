//
//  Transaction.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "Receipt.h"
//#import "Transaction.h"
//#import "PaymentData.h"
//#import "Merchant.h"

@implementation Receipt

///Initialize user object from Server Class RLMUser
//- (id _Nonnull) initWithTransaction:(Transaction* _Nonnull) transaction paymentData:(PaymentData* _Nonnull) paymentData
//{
//    if (self = [super init]) {
//        _merchantName = transaction.merchantName;
//        _merchantCity = paymentData.merchant.city;
//        _transactionAmount = transaction.transactionAmount;
//        _tipAmount = transaction.tipAmount;
//        _totalAmount = transaction.tipAmount + transaction.transactionAmount;
//        _currencyCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:transaction.currencyNumericCode]];
//        _maskedPan = transaction.maskedIdentifier;
//        _methodType = @"";
//        _currencyNumericCode = transaction.currencyNumericCode;
//        if (paymentData.eWayBill.length > 0) {
//            _message = @"Thank you for your payment. Your GST status has been updated automatically.";
//        }else
//        {
//            _message = @"You have made a successful payment.";
//        }
//    }
//    return self;
//}

@end
