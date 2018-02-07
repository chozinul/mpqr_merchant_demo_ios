//
//  GenericRadioButtonTableViewCell.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLRadioButton;

/**
 Generic input that require radio button table view cell.
 */
@interface GenericRadioButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet DLRadioButton *radioValue;

@end
