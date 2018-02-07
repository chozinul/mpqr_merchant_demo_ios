//
//  TransactionDetailViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Transaction;

/**
 Cell to display detailed transaction items
 */
@interface TransactionDetailViewCell : UITableViewCell

@end

/**
 UIViewController to display detailed transaction
 */
@interface TransactionDetailViewController : BaseViewController

///Transaction to be display
@property Transaction* transaction;

@end
