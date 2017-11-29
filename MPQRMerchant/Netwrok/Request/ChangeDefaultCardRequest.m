//
//  ChangeDefaultCardRequest.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 1/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "ChangeDefaultCardRequest.h"

@implementation ChangeDefaultCardRequest

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode index:(int) index
{
    if (self = [super init]) {
        self.accessCode = accessCode;
        self.index = index;
    }
    return self;
}

@end
