//
//  Settings.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property NSString* title;
@property NSString* value;
@property BOOL isEditable;

+ (instancetype) SettingWithTitle:(NSString*) title value:(NSString*) value isEditable:(BOOL) isEditable;

@end
