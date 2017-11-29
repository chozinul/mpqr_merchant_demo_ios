//
//  RealmDataSource.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

@class User;
@class Transaction;
@import Realm;

@interface RealmDataSource : NSObject<DataSource>

+ (instancetype _Nonnull )sharedInstance;


- (User* _Nullable) saveUser:(User* _Nullable) user;
- (User* _Nullable) getUser:(long) userId;
- (Transaction* _Nullable) getTransaction:(NSString* _Nonnull) referenceId;
- (RLMArray<Transaction*><Transaction>* _Nullable) getTransactions:(long) userId;
- (BOOL) deleteUser:(long) userId;
- (Transaction* _Nullable) saveTransaction:(long) userId transaction:(Transaction* _Nullable) transaction;
@end
