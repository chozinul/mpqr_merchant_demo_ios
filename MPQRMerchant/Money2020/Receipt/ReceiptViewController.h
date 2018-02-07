//
//  ReceiptViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 30/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Receipt;
/**
 Responsible to display receipt of the transaction
 */
@interface ReceiptViewController : BaseViewController

///Receipt to be displayed
@property Receipt* receipt;

@end
