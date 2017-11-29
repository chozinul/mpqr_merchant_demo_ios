//
//  MakePaymentRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "BaseRequest.h"

@interface MakePaymentRequest : BaseRequest

@property long senderCardID;
@property long senderID;
@property NSString* _Nullable receiverCardNumber;
@property NSString* _Nullable receiverName;
@property NSString* _Nullable currency;
@property double transactionAmountTotal;
@property double tipAmount;
@property NSString* _Nullable terminalNumber;

- (id _Nonnull) initWithAccesCode:(NSString*_Nullable) accessCode senderID:(long) senderID senderCardID:(long) senderCardID receiverCardNumber:(NSString* _Nullable) receiverCardNumber receiverName:(NSString* _Nullable) receiverName currency:(NSString* _Nullable) currency transactionAmountTotal:(double) transactionAmountTotal tipAmount:(double) tipAmount terminalNumber:(NSString* _Nullable) terminalNumber;

@end
