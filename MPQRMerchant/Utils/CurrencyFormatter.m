//
//  CurrencyFormatter.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "CurrencyFormatter.h"

@implementation CurrencyFormatter

+ (NSString*) getFormattedAmountWithValue:(double) value{
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2]; // Set this if you need 2 digits
    [formatter setLocale:[NSLocale currentLocale]];
    NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
    return newString;
}

/**
 Format the currency based in the number of decimal value given
 */
+ (NSString*) getFormattedAmountWithValue:(double) value decimalPoint:(int) decimalPoint{
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    NSString* newString = [NSString stringWithFormat:formatString, value];
    return newString;
}

@end
