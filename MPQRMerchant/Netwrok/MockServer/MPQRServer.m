//
//  MPQRServer.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "MPQRServer.h"
#import "PaymentInstrument.h"
#import "Transaction.h"
#import "User.h"
#include <stdlib.h>
#import "LoginResponse.h"
#import "PaymentInstrument.h"
#import "LoginRequest.h"
#import "GetUserInfoRequest.h"
#import "TransactionsRequest.h"
#import "PreferenceManager.h"

@interface MPQRServer()

@end

@implementation MPQRServer
static NSString * const MERCHANT_NAME_KEY = @"merchantName";
static NSString * const MERCHANT_IDENTIFIER_KEY = @"merchantIdentifier";
static NSString * const MERCHANT_COUNTRY_CODE_KEY = @"merchantCountryCode";
static NSString * const MERCHANT_CITY_KEY = @"merchantCity";
static NSString * const MERCHANT_CURRENCY_NUMERIC_CODE_KEY = @"merchantCurrencyNumericCode";
static NSString * const MERCHANT_TRANSACTIONS_LIST_KEY = @"merchantTransactions";
static NSString * const MERCHANT_PHONE_KEY = @"merchantPhone";
static NSString * const MERCHANT_CODE = @"87654321";
static NSString * const MERCHANT_PIN = @"123456";

static NSString* DEFAULT_MERCHANT_NAME;
static NSString* DEFAULT_MERCHANT_COUNTRY_CODE;
static NSString* DEFAULT_MERCHANT_CITY;
static NSString* DEFAULT_MERCHANT_CURRENCY_NUMERIC_CODE;
static NSString* DEFAULT_MERCHANT_IDENTIFIER;
static NSString* DEFAULT_MERCHANT_PHONE;

///Singleton
+ (instancetype _Nonnull)sharedInstance
{
    static MPQRServer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPQRServer alloc] init];
        // Do any other initialisation stuff here
        
        
    });
    return sharedInstance;
}

///Initializer
- (id) init
{
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource: @"init" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        if (dict) {
            DEFAULT_MERCHANT_NAME = [dict objectForKey:MERCHANT_NAME_KEY];
            DEFAULT_MERCHANT_COUNTRY_CODE = [dict objectForKey:MERCHANT_COUNTRY_CODE_KEY];
            DEFAULT_MERCHANT_CITY = [dict objectForKey:MERCHANT_CITY_KEY];
            DEFAULT_MERCHANT_CURRENCY_NUMERIC_CODE = [dict objectForKey:MERCHANT_CURRENCY_NUMERIC_CODE_KEY];
            DEFAULT_MERCHANT_IDENTIFIER = [dict objectForKey:MERCHANT_IDENTIFIER_KEY];
            DEFAULT_MERCHANT_PHONE = [dict objectForKey:MERCHANT_PHONE_KEY];
        }else
        {
            DEFAULT_MERCHANT_NAME = @"Go Go Transport";
            DEFAULT_MERCHANT_COUNTRY_CODE = @"IN";
            DEFAULT_MERCHANT_CITY = @"Delhi";
            DEFAULT_MERCHANT_CURRENCY_NUMERIC_CODE = @"356";
            DEFAULT_MERCHANT_IDENTIFIER = @"5555222233334444";
            DEFAULT_MERCHANT_PHONE = @"";
        }
        
    }
    return self;
}

#pragma mark - API Call
/**
 Server API for get, all the call will go through this method:
    - Login
    - Get user information
    - Get sample transactions
 */
- (nullable NSURLSessionDataTask *)GET:(nullable NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    ///block that handle the login
    if ([URLString isEqualToString:@"/login"]) {
        LoginRequest* loginRequest = (LoginRequest*) parameters;
        //isvalidcredential
        NSString* strAccesCode = loginRequest.accessCode;
        NSString* strPin = loginRequest.pin;
        if(![self isValidCredential:strAccesCode pin:strPin])
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Invalid credential"}];
            failure(nil, error);
            return nil;
        }
        
        LoginResponse* loginResponse = [LoginResponse new];
        loginResponse.accessCode = strAccesCode;
        loginResponse.token = @"asdlfj09u09uewjffij";
        User* user = [self createDefaultUser];
        loginResponse.userId = user.id;
        success(nil, loginResponse);
    }
    
    ///Block that handle user info
    if ([URLString isEqualToString:@"/getuserinfo"]) {
        GetUserInfoRequest* params = (GetUserInfoRequest*) parameters;
        NSString* strAccessCode = params.accessCode;
        if(!strAccessCode)
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Access code is null"}];
            failure(nil, error);
            return nil;
        }
        success(nil, [self createDefaultUser]);
    }
   
    ///Block that handle the list of transactions
    if ([URLString isEqualToString:@"/transactions"]) {
        TransactionsRequest* request = (TransactionsRequest*) parameters;
        long cardId = request.senderCardIdentifier;
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults<Transaction*> *list = [Transaction objectsInRealm:realm where:[NSString stringWithFormat:@"instrumentIdentifier = %ld", cardId]];
        
        if (list.count>0) {
            success(nil, list);
        }else
        {
            NSError* error = [NSError errorWithDomain:@"Network Error" code:500 userInfo:@{@"description":@"Transaction is not found"}];
            failure(nil, error);
            return nil;
        }
    }
    
    ///Logout
    if ([URLString isEqualToString:@"/logout"]) {
        success(nil, nil);
    }
    
    return nil;
}

#pragma mark - Login
///Check if valid credential, any accesscode/password with 123456 will go through
- (BOOL) isValidCredential:(NSString*) accessCode pin:(NSString*) pin
{
    if (![pin isEqualToString:@"123456"]) {
        return false;
    }
    
    if (!accessCode) {
        return false;
    }
    return true;
}

///Create default user, any user that login will have this default value
- (User*) createDefaultUser
{
    NSString* merchantName = [[PreferenceManager sharedInstance] getString:MERCHANT_NAME_KEY default:DEFAULT_MERCHANT_NAME];
    NSString* merchantIdentifier = [[PreferenceManager sharedInstance] getString:MERCHANT_IDENTIFIER_KEY default:DEFAULT_MERCHANT_IDENTIFIER];
    NSString* merchantCountryCode = [[PreferenceManager sharedInstance] getString:MERCHANT_COUNTRY_CODE_KEY default:DEFAULT_MERCHANT_COUNTRY_CODE];
    NSString* merchantCity = [[PreferenceManager sharedInstance] getString:MERCHANT_CITY_KEY default:DEFAULT_MERCHANT_CITY];
    NSString* merchantCurrencyNumericCode = [[PreferenceManager sharedInstance] getString:MERCHANT_CURRENCY_NUMERIC_CODE_KEY default:DEFAULT_MERCHANT_CURRENCY_NUMERIC_CODE];
    NSString* merchantPhone = [[PreferenceManager sharedInstance] getString:MERCHANT_PHONE_KEY default:DEFAULT_MERCHANT_PHONE];
    
    User* user = [User new];
    user.id = 992641;
    user.code = MERCHANT_CODE;
    user.name = merchantName;
    user.city = merchantCity;
    user.countryCode = merchantCountryCode;
    user.categoryCode = @"1234";
    user.currencyNumericCode = merchantCurrencyNumericCode;
    user.identifierMastercard04 = merchantIdentifier;
    user.storeId = @"87654321";
    user.terminalNumber = @"3124652125";
    user.mobile = merchantPhone;
    NSArray* transactions = [self createTransactions:user];
    for (Transaction* transaction in transactions) {
        [user.transactions addObject:transaction];
    }
    [self printUser:user];
    return user;
}

///Create list of transaction, taken from transaction.JSON
- (NSArray*) createTransactions:(User*) user
{
    NSMutableArray* arrayResult = [NSMutableArray new];
    NSDictionary* dictJSON = [self JSONFromFile];
    NSArray* arrayTransaction = [dictJSON objectForKey:@"transactions"];
    for (int i = 0; i < arrayTransaction.count; i++) {
        NSDictionary* dictTrans = [arrayTransaction objectAtIndex:i];
        Transaction* tr = [Transaction new];
        tr.invoiceNumber = [dictTrans objectForKey:@"invoiceNumber"];
        tr.currencyNumericCode = [dictTrans objectForKey:@"currencyNumericCode"];
        tr.tipAmount = [[dictTrans objectForKey:@"tipAmount"] doubleValue];
        tr.transactionAmount = [[dictTrans objectForKey:@"transactionAmount"] doubleValue];
        
        NSString *dateString = [dictTrans objectForKey:@"transactionDate"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
        NSDate *dateFromString = [dateFormatter dateFromString:dateString];
        
        tr.transactionDate = dateFromString;
        tr.referenceId = [dictTrans objectForKey:@"referenceId"];
        tr.terminalNumber = [dictTrans objectForKey:@"terminalNumber"];
        tr.merchantName = user.name;
        tr.instrumentIdentifier = 1;
        tr.maskedIdentifier = user.identifierMastercard04;
        [arrayResult addObject:tr];
    }
    return arrayResult;
}

///Read transaction.JSON file and convert to dictionary
- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Transaction" ofType:@"JSON"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

///Debugging user information
- (void) printUser:(User*) user
{
    for (int i = 0; i < user.transactions.count; i++) {
        Transaction* tran = [user.transactions objectAtIndex:i];
        NSLog(@"%@", tran.referenceId);
    }
}

@end
