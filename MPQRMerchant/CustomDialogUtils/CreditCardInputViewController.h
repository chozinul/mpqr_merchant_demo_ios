//
//  CreditCardInputViewController.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 8/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "DialogViewController.h"

/**
 Input control to input credit card from setting page 
 */
@interface CreditCardInputViewController : DialogViewController

@property NSString* dialogTitle;
@property NSString* dialogDescription;

@property NSString* strValue;

@end
