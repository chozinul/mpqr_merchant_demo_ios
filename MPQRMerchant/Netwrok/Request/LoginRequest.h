//
//  LoginRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

///Login request
@interface LoginRequest : BaseRequest

///Pin is necessary in login request
@property NSString* _Nonnull pin;


///Initializer of the request with acceess code and pin
- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode pin:(NSString* _Nonnull) pin;

@end
