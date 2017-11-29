//
//  RealmDataSource.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "RealmDataSource.h"
#import "User.h"
#import "Transaction.h"

@import Realm;

@implementation RealmDataSource

+ (instancetype _Nonnull)sharedInstance
{
    static RealmDataSource *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RealmDataSource alloc] init];
    });
    return sharedInstance;
}


- (User*) saveUser:(User*) user
{
    if (!user) {
        return nil;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:user];
    [realm commitWriteTransaction];
    return user;
}
- (User*) getUser:(long) userId
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld",userId]];
    return [users firstObject];
}
- (Transaction*) getTransaction:(NSString*) referenceId
{
    if(!referenceId)return nil;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<Transaction*> *transactions = [Transaction objectsInRealm:realm where:[NSString stringWithFormat:@"referenceID = '%@'",referenceId]];
    return transactions.firstObject;
    
}
- (RLMArray<Transaction*><Transaction>*) getTransactions:(long) userId
{
    if(!userId)return nil;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld",userId]];
    if (users) {
        User* user = users.firstObject;
        return user.transactions;
    }
    return nil;
}

- (BOOL) deleteUser:(long) userId
{
    if(!userId)return false;
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld",userId]];
    if (!users) {
        return false;
    }
    [realm beginWriteTransaction];
    [realm deleteObjects:users];
    [realm commitWriteTransaction];
    
    return true;
}
- (Transaction*) saveTransaction:(long) userId transaction:(Transaction*) transaction
{
    if (!transaction) {
        return nil;
    }
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<User*> *users = [User objectsInRealm:realm where:[NSString stringWithFormat:@"id = %ld",userId]];
    if (users) {
        User* user = users.firstObject;
        [realm beginWriteTransaction];
        [user.transactions addObject:transaction];
        [realm commitWriteTransaction];
        return transaction;
    }
    return nil;
}

@end
