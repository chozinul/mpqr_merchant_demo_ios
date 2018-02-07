//
//  UserManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

/**
 It store user information
 It provide convenient access to user attributes
 */
@interface UserManager : NSObject

+ (instancetype _Nonnull )sharedInstance;

@property  User* _Nullable currentUser;


@end
