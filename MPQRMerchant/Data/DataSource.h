//
//  DataSource.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "User.h"
@import Realm;

@protocol DataSource

- (User*) saveUser:(User*) user;
- (User*) getUser:(long) userId;
- (Transaction*) getTransaction:(NSString*) referenceId;
- (RLMArray<Transaction*><Transaction>*) getTransactions:(long) userId;
- (BOOL) deleteUser:(long) userId;
- (Transaction*) saveTransaction:(long) userId transaction:(Transaction*) transaction;


@end

