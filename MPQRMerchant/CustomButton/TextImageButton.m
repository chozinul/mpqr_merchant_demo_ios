//
//  TextImageButton.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 8/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "TextImageButton.h"

@implementation TextImageButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    CGRect lblRect = self.titleLabel.frame;
    imageRect.origin.x = lblRect.size.width;
    lblRect.origin.x = 0;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = lblRect;
}

@end
