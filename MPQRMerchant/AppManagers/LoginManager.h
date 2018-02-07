//
//  LoginManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LoginResponse;
/**
 Responsible to store login information, username and token
 */
@interface LoginManager : NSObject

///Singleton object
+ (instancetype _Nonnull )sharedInstance;

///Login information, username and token
@property (nonatomic, retain)LoginResponse* _Nullable loginInfo;

///Last username
@property (readonly) NSString* _Nonnull lastUser;

@end

