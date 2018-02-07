//
//  RealmDataSource.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

@class User;
@class Transaction;
@import Realm;

/**
 Data sourcce protocol/interface that need to be implemented for the application.
 
 In the case of this application the data source will be implemented using RealmDataSource.
 
 There are 2 kinds of model:
    - Subclass of RLMModel, this model will persist in the database even if the user close the application
    - Subclass of NSObject, this model will not be stored in database
 */

@interface RealmDataSource : NSObject<DataSource>

+ (instancetype _Nonnull )sharedInstance;

@end
