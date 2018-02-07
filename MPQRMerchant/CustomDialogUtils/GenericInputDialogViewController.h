//
//  GenericInputDialogViewController.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "DialogViewController.h"

/**
 It is used as generic input to ented some value in the setting.
 */
@interface GenericInputDialogViewController : DialogViewController

@property NSString* dialogTitle;
@property NSString* dialogDescription;

@property NSString* strValue;

@end
