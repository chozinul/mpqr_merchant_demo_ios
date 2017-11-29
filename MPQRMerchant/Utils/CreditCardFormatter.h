//
//  CreditCardFormatter.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditCardFormatter : NSObject

+ (NSString*) getFormattedCreditCardOfString:(NSString*) creditCardNumber;

@end
