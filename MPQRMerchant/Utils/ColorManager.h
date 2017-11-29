//
//  ColorManager.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorManager : NSObject

+ (instancetype _Nonnull)sharedInstance;

- (UIColor* _Nonnull) semiTransparentBackground;
- (UIColor* _Nonnull) lineDevider;
- (UIColor* _Nonnull) textColor;
- (UIColor* _Nonnull) blackColorHeader;
- (UIColor* _Nonnull) radioButtonSelectedColor;
- (UIColor* _Nonnull) radioButtonUnselectedColor;
- (UIColor* _Nonnull) textFieldColor;

@end
