//
//  MPQRService.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class LoginResponse;
@class User;
@class Transaction;

/**
 Responsible for communication app with mock server
 - In real app, responsible for parsing response from server to object
 - In real app, responsible for change request object to parameters
 - Responsible to call server API
 */
@interface MPQRService : NSObject

///Singleton instant
+ (instancetype _Nonnull )sharedInstance;

///Web API for login
- (void) loginWithParameters:(nullable id)parameters
                     success:(nullable void (^)(LoginResponse* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

///Web API for logout
- (void) logoutWithParameters:(nullable id)parameters
                     success:(nullable void (^)(id _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

///Web API for get user info
- (void) getUserWithParameters:(nullable id)parameters
                     success:(nullable void (^)(User* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
