//
//  GenericRadioButtonTableViewCell.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLRadioButton;
@interface GenericRadioButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet DLRadioButton *radioValue;

@end
