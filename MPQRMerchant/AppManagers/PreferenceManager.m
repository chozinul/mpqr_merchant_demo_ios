//
//  PreferenceManager.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 5/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "PreferenceManager.h"

@implementation PreferenceManager

static NSUserDefaults* userDefault;

+ (instancetype _Nonnull)sharedInstance
{
    static PreferenceManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PreferenceManager alloc] init];
        // Do any other initialisation stuff here
        userDefault = [NSUserDefaults standardUserDefaults];
    });
    return sharedInstance;
}

- (NSString*) getString:(NSString*) key default:(NSString*) defaultValue
{
    NSString* value = [userDefault objectForKey:key];
    if (!value) {
        return defaultValue;
    }
    return value;
}

- (BOOL) putString:(NSString*) key value:(NSString*) value
{
    if (!value) {
        return false;
    }
    [userDefault setObject:value forKey:key];
    return true;
}

@end
