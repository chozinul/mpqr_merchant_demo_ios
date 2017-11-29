//
//  LoginManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginManager.h"
#import "LoginResponse.h"

@interface LoginManager()

@end

@implementation LoginManager

static NSString* _lastUser;

+ (instancetype _Nonnull)sharedInstance
{
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginManager alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _lastUser = [defaults objectForKey:@"last access code"];
        
        NSString *path = [[NSBundle mainBundle] pathForResource: @"init" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        _lastUser = [dict objectForKey: @"lastAccessCode"];
        
        if (!_lastUser) {
            _lastUser = @"87654321";
        }
    });
    return sharedInstance;
}

- (void) setLoginInfo:(LoginResponse *)loginInfo
{
    if (loginInfo.accessCode) {
        _lastUser = loginInfo.accessCode;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_lastUser forKey:@"last access code"];
    }
    _loginInfo = loginInfo;
}

- (NSString*) lastUser
{
    return _lastUser;
}



@end
