//
//  MPQRService.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class LoginResponse;
@class User;
@class Transaction;


@interface MPQRService : NSObject

+ (instancetype _Nonnull )sharedInstance;

- (void) loginWithParameters:(nullable id)parameters
                     success:(nullable void (^)(LoginResponse* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;


- (void) logoutWithParameters:(nullable id)parameters
                     success:(nullable void (^)(id _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) getUserWithParameters:(nullable id)parameters
                     success:(nullable void (^)(User* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError * _Nullable error))failure;


- (void) changeDefaultCardWithParameters:(nullable id)parameters
                       success:(nullable void (^)(User* _Nullable responseObject))success
                       failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) makePaymentWithParameters:(nullable id)parameters
                                 success:(nullable void (^)(id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSError * _Nullable error))failure;

- (void) getTransactionsParameters:(nullable id)parameters
                           success:(nullable void (^)(RLMResults<Transaction*> * _Nullable responseObject))success
                           failure:(nullable void (^)(NSError * _Nullable error))failure;

@end
