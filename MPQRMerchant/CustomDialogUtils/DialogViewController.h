//
//  DialogViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class DialogViewController;
typedef void (^DialogViewControllerCompletionBlock)(DialogViewController* _Nonnull dialogVC);

@interface DialogViewController : BaseViewController

@property  NSString* _Nullable  dialogMessage;
@property  NSString* _Nullable  positiveResponse;
@property  NSString* _Nullable  negativeResponse;
@property  int dialogHeight;

- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withYesBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) success withNoBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) success;

@end
