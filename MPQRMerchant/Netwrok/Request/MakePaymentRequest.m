//
//  MakePaymentRequest.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "MakePaymentRequest.h"

@implementation MakePaymentRequest

- (id _Nonnull) initWithAccesCode:(NSString*_Nullable) accessCode senderID:(long) senderID senderCardID:(long) senderCardID receiverCardNumber:(NSString* _Nullable) receiverCardNumber receiverName:(NSString* _Nullable) receiverName currency:(NSString* _Nullable) currency transactionAmountTotal:(double) transactionAmountTotal tipAmount:(double) tipAmount terminalNumber:(NSString* _Nullable) terminalNumber
{
    if (self = [super init]) {
        self.accessCode = accessCode;
        self.senderID = senderID;
        self.senderCardID = senderCardID;
        self.transactionAmountTotal = transactionAmountTotal;
        self.tipAmount = tipAmount;
        self.receiverCardNumber = receiverCardNumber;
        self.receiverName = receiverName;
        self.currency = currency;
        self.terminalNumber = terminalNumber;
    }
    return self;
}

@end
