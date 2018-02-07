//
//  Settings.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 3/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "Settings.h"

/**
 Setting item that is used for storing setting/preference data for the user.
 */
@implementation Settings


+ (instancetype) SettingWithTitle:(NSString*) title value:(NSString*) value isEditable:(BOOL) isEditable
{
    return [[self alloc] initWithTitle:title value:value isEditable:isEditable];
}

- (id) initWithTitle:(NSString*) title value:(NSString*) value isEditable:(BOOL) isEditable
{
    if (self = [super init]) {
        self.title = title;
        self.value = value;
        self.isEditable = isEditable;
    }
    return self;
}

@end
