//
//  CreditCardFormatter.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class to format credit card display.
 */
@interface CreditCardFormatter : NSObject

+ (NSString*) getFormattedCreditCardOfString:(NSString*) creditCardNumber;

@end
