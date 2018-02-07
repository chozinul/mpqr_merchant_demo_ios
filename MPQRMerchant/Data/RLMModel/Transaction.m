//
//  Transaction.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 25/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "Transaction.h"

/**
 Sample transaction for display and can be access from main page.
 
 Sample transaction that will be stored in RLM database.
 */
@implementation Transaction

///Get formatted display of the date
- (NSString*) getFormattedTransactionDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/M/dd hh:mm"];
    NSDate* date = self.transactionDate;
    return [dateFormatter stringFromDate:date];
}

///Get enum for the currency code
- (CurrencyEnum) getCurrencyCode
{
    return [CurrencyEnumLookup enumFor:_currencyNumericCode];
}


///This method is to be used to compare to its own object
///Its usefull if the object is used for example as the key for a dictionary
- (BOOL) isEqual:(id _Nullable)object
{
    if (![object isKindOfClass:[Transaction class]]) {
        return false;
    }
    if (self == object) {
        return true;
    }
    Transaction* other = (Transaction*) object;
    BOOL referenceIdEqual = (!self.referenceId && !other.referenceId) ||[self.referenceId isEqualToString:other.referenceId];
    BOOL invoiceNumberEqual = (!self.invoiceNumber && !other.invoiceNumber) ||[self.invoiceNumber isEqualToString:other.invoiceNumber];
    BOOL maskedIdentifierEqual = (!self.maskedIdentifier && !other.maskedIdentifier) ||[self.maskedIdentifier isEqualToString:other.maskedIdentifier];
    BOOL transactionAmountEqual = self.transactionAmount == other.transactionAmount;
    BOOL tipAmountEqual = self.tipAmount == other.tipAmount;
    BOOL currencyNumericCodeEqual = (!self.currencyNumericCode && !other.currencyNumericCode) ||[self.currencyNumericCode isEqualToString:other.currencyNumericCode];
    BOOL transactionDateEqual = (!self.transactionDate && !other.transactionDate) || [self.transactionDate isEqual:other.transactionDate];
    BOOL merchantNameEqual = (!self.merchantName && !other.merchantName) ||[self.merchantName isEqualToString:other.merchantName];
    return referenceIdEqual
    && invoiceNumberEqual
    && maskedIdentifierEqual
    && transactionAmountEqual
    && tipAmountEqual
    && currencyNumericCodeEqual
    && transactionDateEqual
    && merchantNameEqual;
}


///This method is to generate unique hash for this object
///Its usefull if the object is used for example as the key for a dictionary
- (NSUInteger)hash
{
    NSUInteger totalInt=0;
    totalInt += [_referenceId hash];
    totalInt += [_invoiceNumber hash];
    totalInt += [_maskedIdentifier hash];
    totalInt += [_currencyNumericCode hash];
    totalInt += [_transactionDate hash];
    totalInt += [_merchantName hash];
    totalInt += [_transactionDate hash];
    totalInt += (NSInteger)_transactionAmount;
    totalInt += (NSInteger)_tipAmount;
    return totalInt;
}

@end
