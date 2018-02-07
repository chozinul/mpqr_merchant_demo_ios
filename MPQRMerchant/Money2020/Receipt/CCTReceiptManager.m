//
//  CCTReceiptManager.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 30/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "CCTReceiptManager.h"
#import "Receipt.h"
#import "CurrencyCode.h"
#import "LoginManager.h"
#import "RealmDataSource.h"
#import "User.h"
#import "LoginResponse.h"

@interface CCTReceiptManager(){
    
}


@property ReceiptViewControllerCompletionBlock _Nullable completionBlockSuccess;
@property ReceiptViewControllerCompletionBlock _Nullable completionBlockFail;

@end

@implementation CCTReceiptManager

///Singleton object
+ (instancetype _Nonnull)sharedInstance
{
    static CCTReceiptManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCTReceiptManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withParam:(nullable NSDictionary*) parameters withYesBlock:(nullable void (^)(ReceiptViewController* _Nonnull dialogVC)) success withNoBlock:(nullable void (^)(ReceiptViewController* _Nonnull dialogVC)) fail
{
    _completionBlockFail = fail;
    _completionBlockSuccess = success;
    
    ReceiptViewController* receiptVC =
    [[UIStoryboard storyboardWithName:@"Payment" bundle:nil] instantiateViewControllerWithIdentifier:@"ReceiptViewController"];
    
    long userId = [LoginManager sharedInstance].loginInfo.userId;
    User* user = [[RealmDataSource sharedInstance] getUser:userId];
    
    Receipt* receipt = [Receipt new];
    receipt.merchantName = user.name;
    receipt.merchantCity = user.city;
    receipt.transactionAmount = [[parameters objectForKey:@"transactionAmount"] doubleValue];
    receipt.tipAmount = [[parameters objectForKey:@"tipAmount"] doubleValue];
    receipt.totalAmount = receipt.tipAmount + receipt.transactionAmount;
    receipt.currencyNumericCode = [parameters objectForKey:@"currencyNumericCode"];
    receipt.currencyCode = [[CurrencyCode sharedInstance] getCountryOfCode:receipt.currencyNumericCode];
    receipt.maskedPan = @"";
    receipt.methodType = @"";
    receipt.message = @"You have received payment from customer.";
    receiptVC.receipt = receipt;
    
    receiptVC.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [vc presentViewController:receiptVC animated:NO completion:nil];
}

@end
