//
//  SettingTableViewCell.h
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIImageView *clickableIndicator;

@end
