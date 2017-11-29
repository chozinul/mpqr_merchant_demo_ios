//
//  TransactionsRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "BaseRequest.h"

@interface TransactionsRequest : BaseRequest

@property long senderCardIdentifier;

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode senderCardIdentifier:(long) senderCardIdentifier;

@end
