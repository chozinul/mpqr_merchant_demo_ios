//
//  MPQRService.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "MPQRService.h"
#import "MPQRServer.h"
#import "Transaction.h"

@implementation MPQRService

+ (instancetype _Nonnull)sharedInstance
{
    static MPQRService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPQRService alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void) loginWithParameters:(nullable id)parameters
                     success:(nullable void (^)(LoginResponse* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError* _Nullable error))failure
{
        [[MPQRServer sharedInstance] GET:@"/login"
                              parameters:parameters
                                 success:^(NSURLSessionDataTask* task, id response){
                                     success(response);
                                 } failure:^(NSURLSessionDataTask* task, NSError* error){
                                     failure(error);
                                 }];
}


- (void) logoutWithParameters:(nullable id)parameters
                      success:(nullable void (^)(id _Nullable responseObject))success
                      failure:(nullable void (^)(NSError * _Nullable error))failure
{
    
    [[MPQRServer sharedInstance] GET:@"/logout"
                          parameters:parameters
                             success:^(NSURLSessionDataTask* task, id response){
                                 success(response);
                             } failure:^(NSURLSessionDataTask* task, NSError* error){
                                 failure(error);
                             }];
}


- (void) getUserWithParameters:(nullable id)parameters
                     success:(nullable void (^)(User* _Nullable responseObject))success
                     failure:(nullable void (^)(NSError* _Nullable error))failure
{
    [[MPQRServer sharedInstance] GET:@"/getuserinfo"
                          parameters:parameters
                             success:^(NSURLSessionDataTask* task, id response){
                                 success(response);
                             } failure:^(NSURLSessionDataTask* task, NSError* error){
                                 failure(error);
                             }];
}

@end
