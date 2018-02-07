//
//  TransactionListViewController.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

/**
 UITableViewCell to display transaction items.
 */
@interface TransactionViewCell : UITableViewCell

@end

/**
 This class is to display all the transaction that has been done by particulat payment instrument (card)
 It will retrieve the transaction data from the MPQR server and display it
 */
@interface TransactionListViewController : BaseViewController

@end
