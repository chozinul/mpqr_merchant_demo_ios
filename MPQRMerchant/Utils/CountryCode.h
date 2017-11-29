//
//  CountryCode.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryCode : NSObject

+ (instancetype _Nonnull)sharedInstance;


- (NSString* _Nullable) getCountryOfCode:(NSString* _Nonnull) strCode;
- (NSString* _Nullable) getCodeOfCountry:(NSString* _Nonnull) strCountry;
- (NSArray* _Nonnull) getAllCountries;
@end
