//
//  BaseRequest.h
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 31/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

@property NSString* _Nullable accessCode;

- (id _Nonnull) initWithAccessCode:(NSString* _Nonnull) accessCode;

@end
