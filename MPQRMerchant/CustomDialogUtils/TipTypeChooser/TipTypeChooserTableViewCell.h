//
//  TipTypeChooserTableViewCell.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLRadioButton;

///Table view cell for tip type input
@interface TipTypeChooserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet DLRadioButton *radioDefault;

@end
