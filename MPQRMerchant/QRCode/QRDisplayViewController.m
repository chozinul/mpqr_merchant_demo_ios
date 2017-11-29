//
//  QRDisplayViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "QRDisplayViewController.h"
#import "QRData.h"
#import "CurrencyFormatter.h"

@import MasterpassQRCoreSDK;
@import CoreImage;

@interface QRDisplayViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *qrImgaeView;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantCode;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantName;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchantCity;

@end

@implementation QRDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _qrImgaeView.image = [self generateQRCode:_strQRCode];
    _lblTotalMoney.text = [NSString stringWithFormat:@"%@ %@"
                           , [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_qrData.currencyNumericCode]]
                           , [NSString stringWithFormat:[self getDecimalPointFormatter],[self calculateTotalAmount]]
                           ];
    _lblMerchantCode.text = [NSString stringWithFormat:@"Merchant Code: %@", _qrData.merchantIdentifierMastercard04];
    _lblMerchantName.text = _qrData.merchantName;
    _lblMerchantCity.text = _qrData.merchantCity;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (double) calculateTotalAmount
{
    double totalAmount = 0;
    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            totalAmount = _qrData.transactionAmount*(1+_qrData.tip/100.0);
            break;
        case flatConvenienceFee:
            totalAmount = _qrData.transactionAmount + _qrData.tip;
            break;
        case promptedToEnterTip:
            totalAmount = _qrData.transactionAmount + _qrData.tip;
            break;
        default:
            totalAmount = _qrData.transactionAmount + _qrData.tip;
            break;
    }
    return totalAmount;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)generateQRCode:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (!filter || !data)
        return nil;
    
    [filter setValue:data forKey:@"inputMessage"];
    CGAffineTransform transform = CGAffineTransformMakeScale(3, 3);
    CIImage *image = [[filter outputImage] imageByApplyingTransform:transform];
    return [UIImage imageWithCIImage:image];
}

- (NSString*) getDecimalPointFormatter
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_qrData.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    return formatString;
}

@end
