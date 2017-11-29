//
//  LoginRequest.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode pin:(NSString* _Nonnull) pin
{
    if (self = [super init]) {
        self.accessCode = accessCode;
        _pin = pin;
    }
    return self;
}

@end
