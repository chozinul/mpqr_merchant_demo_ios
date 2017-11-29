//
//  LoginManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>


@class LoginResponse;
@interface LoginManager : NSObject

+ (instancetype _Nonnull )sharedInstance;

@property (nonatomic, retain) LoginResponse* _Nullable loginInfo;
@property (readonly) NSString* _Nonnull lastUser;

@end
