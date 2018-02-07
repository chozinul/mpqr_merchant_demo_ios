//
//  UserManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "UserManager.h"
#import "PaymentInstrument.h"

@implementation UserManager

+ (instancetype _Nonnull)sharedInstance
{
    static UserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UserManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

@end
