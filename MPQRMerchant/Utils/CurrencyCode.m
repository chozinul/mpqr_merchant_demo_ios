//
//  CurrencyCode.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 8/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "CurrencyCode.h"

@interface CurrencyCode()

@property NSDictionary* dictCodeCountry;

@end

@implementation CurrencyCode


+ (instancetype _Nonnull)sharedInstance
{
    static CurrencyCode *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CurrencyCode alloc] init];
        [sharedInstance initContent];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (NSString*) getCountryOfCode:(NSString*) strCode
{
    NSString* strCountry = [_dictCodeCountry objectForKey:strCode];
    return strCountry;
}

- (NSString*) getCodeOfCountry:(NSString*) strCountry
{
    NSString* strCode = [_dictCodeCountry allKeysForObject:strCountry].firstObject;
    return strCode;
}

- (NSArray*) getAllCountries
{
    NSMutableArray* arrayCountry = [NSMutableArray arrayWithArray:[_dictCodeCountry allValues]];
    [arrayCountry sortUsingComparator:^(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    return arrayCountry;
}

- (void) initContent
{
    if (_dictCodeCountry) {
        return;
    }
    NSString *regexStr=@"...\\(\"(.*)\", \"(\\d\\d\\d)\"\\),";
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Currency"
                                                     ofType:@"init"];
    NSString* inputStr = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSError *regexError;
    NSRegularExpression *aRegx=[NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&regexError];
    NSArray *results=[aRegx matchesInString:inputStr options:0 range:NSMakeRange(0, inputStr.length)];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    for (NSTextCheckingResult *match in results) {
        NSRange first = [match rangeAtIndex:1];
        NSRange second = [match rangeAtIndex:2];
        [dict setObject:[inputStr substringWithRange:first] forKey:[inputStr substringWithRange:second]];
    }
    _dictCodeCountry = dict;
}

@end
