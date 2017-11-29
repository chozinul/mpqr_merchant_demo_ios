//
//  PreferenceManager.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 5/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreferenceManager : NSObject

+ (instancetype _Nonnull )sharedInstance;


- (NSString* _Nullable) getString:(NSString* _Nonnull) key default:(NSString* _Nonnull) defaultValue;
- (BOOL) putString:(NSString* _Nonnull) key value:(NSString* _Nonnull) value;

@end
