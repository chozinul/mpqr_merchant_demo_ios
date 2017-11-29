//
//  UserManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+ (instancetype _Nonnull )sharedInstance;

@property  User* _Nullable currentUser;

//- (int) getDefaultCardIndex;
//- (PaymentInstrument* _Nullable) getDefaultCard;
//- (PaymentInstrument* _Nullable) getuserCardWithID:(NSInteger) ID;

@end
