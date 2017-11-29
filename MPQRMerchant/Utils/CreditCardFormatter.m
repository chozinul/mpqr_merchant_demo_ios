//
//  CreditCardFormatter.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "CreditCardFormatter.h"

@implementation CreditCardFormatter

+ (NSString*) getFormattedCreditCardOfString:(NSString*) originalString
{
    NSMutableString* str = [NSMutableString stringWithString:originalString];
    int spaceCount = 0;
    for (int i = 1; i < str.length; i++) {
        if ((i - spaceCount)%4 == 0) {
            [str insertString:@" " atIndex:i];
            spaceCount++;
            i++;
        }
    }
    return str;
}

+ (NSString*) getOriginalStringOfFormattedCreditCard:(NSString*) creditcardString
{
    return [creditcardString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
