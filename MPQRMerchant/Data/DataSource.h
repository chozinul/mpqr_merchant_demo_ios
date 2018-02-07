//
//  DataSource.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "User.h"
@import Realm;

/**
 Data sourcce protocol/interface that need to be implemented for the application.
 */
@protocol DataSource

///Save user that login to the application
- (User*) saveUser:(User*) user;

///Get user that login to the application
- (User*) getUser:(long) userId;

///Get sample transaction of the application given transactioin reference id
- (Transaction*) getTransaction:(NSString*) referenceId;

///Get all sample transactions of the application
- (RLMArray<Transaction*><Transaction>*) getTransactions:(long) userId;

///Delete particular user
- (BOOL) deleteUser:(long) userId;

///Save transaction
- (Transaction*) saveTransaction:(long) userId transaction:(Transaction*) transaction;


@end

