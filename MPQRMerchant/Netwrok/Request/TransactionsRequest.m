//
//  TransactionsRequest.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "TransactionsRequest.h"

@implementation TransactionsRequest

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode senderCardIdentifier:(long)senderCardIdentifier
{
    if (self = [super init]) {
        self.accessCode = accessCode;
        self.senderCardIdentifier = senderCardIdentifier;
    }
    return self;
}

@end
