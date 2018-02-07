//
//  QRDisplayViewController.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRData;

/**
 The page for displaying QRCode image and some description of it.
 */
@interface QRDisplayViewController : UIViewController

@property QRData* qrData;
@property NSString* strQRCode;

@end
