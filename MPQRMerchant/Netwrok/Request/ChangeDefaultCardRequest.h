//
//  ChangeDefaultCardRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "BaseRequest.h"

@interface ChangeDefaultCardRequest : BaseRequest

@property int index;

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode index:(int) index;

@end
