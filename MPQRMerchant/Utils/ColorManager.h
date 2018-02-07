//
//  ColorManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Manage color of the application that is not done in the user interface
 */
@interface ColorManager : NSObject

+ (instancetype _Nonnull)sharedInstance;

- (UIColor* _Nonnull) semiTransparentBackground;
- (UIColor* _Nonnull) lineDevider;
- (UIColor* _Nonnull) textColor;
- (UIColor* _Nonnull) blackColorHeader;
- (UIColor* _Nonnull) radioButtonSelectedColor;
- (UIColor* _Nonnull) radioButtonUnselectedColor;
- (UIColor* _Nonnull) textFieldColor;

///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledBackgroundColor;
///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledLineColor;
///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledTitleColor;
///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledBackgroundColor;
///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledLineColor;
///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledTitleColor;
///textfield nonzero
- (UIColor* _Nonnull) textFieldNonZeroValueColor;
///textfield zero
- (UIColor* _Nonnull) textFieldZeroValueColor;
@end
