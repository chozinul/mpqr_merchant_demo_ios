//
//  TipTypeDialogViewController.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "DialogViewController.h"

@import MasterpassQRCoreSDK;

/**
 To input the tip type at the main view controller.
 */
@interface TipTypeDialogViewController : DialogViewController

@property  TipConvenienceIndicator tipType;

@end
