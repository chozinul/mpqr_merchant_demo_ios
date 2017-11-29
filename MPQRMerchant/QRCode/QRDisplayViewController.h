//
//  QRDisplayViewController.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRData;
@interface QRDisplayViewController : UIViewController

@property QRData* qrData;
@property NSString* strQRCode;

@end
