//
//  CurrencyFormatter.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Utility class to format the currency based in the number of decimal value given
 */
@interface CurrencyFormatter : NSObject

/**
 Format the currency based in the number of decimal value given
 */
+ (NSString*) getFormattedAmountWithValue:(double) value;

/**
 Format the currency based in the number of decimal value given
 */
+ (NSString*) getFormattedAmountWithValue:(double) value decimalPoint:(int) decimalPoint;
@end
