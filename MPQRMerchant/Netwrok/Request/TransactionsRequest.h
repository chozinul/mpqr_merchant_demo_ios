//
//  TransactionsRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "BaseRequest.h"

///Transaction list request based on particular card
@interface TransactionsRequest : BaseRequest

///Card identifier that the transactions want to be retrieved
@property long senderCardIdentifier;

///Initializer of the request with acceess code and card identifier
- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode senderCardIdentifier:(long) senderCardIdentifier;

@end
