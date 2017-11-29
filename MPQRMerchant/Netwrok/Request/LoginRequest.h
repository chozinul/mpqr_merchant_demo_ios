//
//  LoginRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

@property NSString* _Nonnull pin;

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode pin:(NSString* _Nonnull) pin;

@end
