//
//  LoginResponse.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Realm/Realm.h>

@interface LoginResponse : RLMObject

@property NSString* accessCode;
@property long userId;
@property NSString* token;

@end
