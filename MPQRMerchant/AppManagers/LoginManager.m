//
//  LoginManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "LoginManager.h"
#import "LoginResponse.h"

@interface LoginManager()

@end

/**
 Save access id and token for server API call
 Save last access code for easier login
 */
@implementation LoginManager

static NSString* _lastUser;

///Singleton object
+ (instancetype _Nonnull)sharedInstance
{
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginManager alloc] init];
        if (!_lastUser) {
            _lastUser = @"jerry";
        }
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

///setter ffor login info
- (void) setLoginInfo:(LoginResponse *)loginInfo
{
    _lastUser = loginInfo.accessCode;
    _loginInfo = loginInfo;
}

///getter for last user
- (NSString*) lastUser
{
    return _lastUser;
}



@end

