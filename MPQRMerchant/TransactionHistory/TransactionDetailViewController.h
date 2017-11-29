//
//  TransactionDetailViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Transaction;
@interface TransactionDetailViewCell : UITableViewCell

@end

@interface TransactionDetailViewController : BaseViewController

@property Transaction* transaction;

@end
