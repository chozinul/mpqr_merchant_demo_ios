//
//  CCTReceiptManager.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 30/1/18.
//  Copyright © 2018 Mastercard. All rights reserved.
//

#import "AppDelegate.h"
#import "ReceiptViewController.h"


typedef void (^ReceiptViewControllerCompletionBlock)(ReceiptViewController* _Nonnull dialogVC);

@interface CCTReceiptManager : AppDelegate


///Singleton object
+ (instancetype _Nonnull )sharedInstance;

///Show Receipt
- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withParam:(nullable NSDictionary*) parameters withYesBlock:(nullable void (^)(ReceiptViewController* _Nonnull dialogVC)) success withNoBlock:(nullable void (^)(ReceiptViewController* _Nonnull dialogVC)) fail;

@end
