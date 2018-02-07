//
//  User.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "User.h"

/**
 User or merchant information that is user for generating QRCode.
 
 User or merchant preference that will be stored in database.
 */
@implementation User


///This method is to be used to compare to its own object
///Its usefull if the object is used for example as the key for a dictionary
- (BOOL) isEqual:(id _Nullable)object
{
    if (![object isKindOfClass:[User class]]) {
        return false;
    }
    if (self == object) {
        return true;
    }
    User* other = (User*) object;
    BOOL idEqual = self.id == other.id;
    BOOL transactionsEqual = (!self.transactions && !other.transactions) || [self.transactions isEqual:other.transactions];
    
    return idEqual
    && transactionsEqual;
}


///This method is to generate unique hash for this object
///Its usefull if the object is used for example as the key for a dictionary
- (NSUInteger)hash
{
    NSUInteger totalInt=0;
    totalInt += _id;
    totalInt += [_transactions hash];
    return totalInt;
}

@end
