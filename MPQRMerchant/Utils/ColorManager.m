//
//  ColorManager.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (instancetype _Nonnull)sharedInstance
{
    static ColorManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ColorManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (UIColor* _Nonnull) semiTransparentBackground
{
    return [UIColor colorWithWhite:0.0 alpha:0.6];
}

- (UIColor* _Nonnull) lineDevider
{
    return [UIColor colorWithRed:231/255.0 green:179/255.0 blue:42/255.0 alpha:1.0];
}

- (UIColor* _Nonnull) textColor
{
    return [UIColor colorWithRed:231/255.0 green:179/255.0 blue:42/255.0 alpha:1.0];
}

- (UIColor* _Nonnull) blackColorHeader
{
    return [UIColor colorWithWhite:0.0 alpha:1.0];
}


- (UIColor* _Nonnull) radioButtonSelectedColor
{
    return [UIColor colorWithRed:231/255.0 green:179/255.0 blue:42/255.0 alpha:1.0];
}

- (UIColor* _Nonnull) radioButtonUnselectedColor
{
    return [UIColor lightGrayColor];
}

- (UIColor* _Nonnull) textFieldColor
{
    return [UIColor colorWithRed:255/255.0 green:248/255.0 blue:221/255.0 alpha:1.0];
}

///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledBackgroundColor
{
    return [UIColor whiteColor];
}

///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledLineColor
{
    return [UIColor colorWithRed:231/255.0 green:179/255.0 blue:42/255.0 alpha:1.0];
}

///textfield enabled
- (UIColor* _Nonnull) textFieldEnabledTitleColor
{
    return [UIColor colorWithRed:231/255.0 green:179/255.0 blue:42/255.0 alpha:1.0];
}



///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledBackgroundColor
{
    return [UIColor colorWithRed:255/255.0 green:248/255.0 blue:221/255.0 alpha:1.0];
}

///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledLineColor
{
    return [UIColor lightGrayColor];
}

///textfield disabled
- (UIColor* _Nonnull) textFieldDisabledTitleColor
{
    return [UIColor darkGrayColor];
}

///textfield nonzero
- (UIColor* _Nonnull) textFieldNonZeroValueColor
{
    return [UIColor blackColor];
}

///textfield zero
- (UIColor* _Nonnull) textFieldZeroValueColor
{
    return [UIColor lightGrayColor];
}

@end
