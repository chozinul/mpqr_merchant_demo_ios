//
//  ViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 2/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "RealmDataSource.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "QRData.h"
#import "DialogViewController.h"
#import "LoginManager.h"
#import "LoginResponse.h"
#import "Transaction.h"
#import "CurrencyFormatter.h"
#import "TipTypeDialogViewController.h"
#import "QRDisplayViewController.h"
#import "TransactionListViewController.h"
#import "MPQRService.h"
#import "LogoutRequest.h"
#import "SettingViewController.h"
#import "CreditCardInputViewController.h"
#import "CurrencyCode.h"
#import "TextImageButton.h"
#import "ColorManager.h"

@interface MainViewController ()
{
    UIView* topBar;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTotalDaily;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalTransactions;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrencyCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrencyCode2;
@property (weak, nonatomic) IBOutlet TextImageButton *btnTipType;
@property (weak, nonatomic) IBOutlet UITextField *txtTransactionAmount;
@property (weak, nonatomic) IBOutlet UITextField *txtTip;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnGenerate;
@property (weak, nonatomic) IBOutlet UIView *section4;
@property (weak, nonatomic) IBOutlet UIView *amountSection;
@property (weak, nonatomic) IBOutlet UIView *tipSection;

@property (nonatomic) UILabel *lblMerchantName;
@property (nonatomic) UILabel *lblMerchantAddress;

@property QRData* qrData;
@property User* mUser;

- (IBAction)chooseTipType:(id)sender;
- (IBAction)openTransactions:(id)sender;
- (IBAction)generateQRCode:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation bar setting
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //setup top bar
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    topBar.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
    topBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _lblMerchantName = [[UILabel alloc] initWithFrame:CGRectZero];
    _lblMerchantName.translatesAutoresizingMaskIntoConstraints = NO;
    _lblMerchantName.font = [UIFont systemFontOfSize:13];
    _lblMerchantName.textColor = [UIColor whiteColor];
    [topBar addSubview:_lblMerchantName];
    _lblMerchantAddress = [[UILabel alloc] initWithFrame:CGRectZero];
    _lblMerchantAddress.translatesAutoresizingMaskIntoConstraints = NO;
    _lblMerchantAddress.font = [UIFont systemFontOfSize:13];
    _lblMerchantAddress.textColor = [UIColor whiteColor];
    [topBar addSubview:_lblMerchantAddress];
    
    [topBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_lblMerchantName]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblMerchantName)]];
    [topBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_lblMerchantAddress]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblMerchantAddress)]];
    [topBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_lblMerchantName(20)][_lblMerchantAddress]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblMerchantAddress,_lblMerchantName)]];
    
    UIBarButtonItem* barBtnSetting = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_settings"]
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(btnSettingPressed)];
    UIBarButtonItem* barBtnLogout = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_logout"]
                                                                     style:UIBarButtonItemStylePlain target:self action:@selector(btnLogoutPressed)];
    self.navigationItem.rightBarButtonItems = @[ barBtnLogout, barBtnSetting];
    
    long userId = [LoginManager sharedInstance].loginInfo.userId;
    User* user = [[RealmDataSource sharedInstance] getUser:userId];
    if (user) {
        
    }else
    {
        LoginViewController* loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    CGRect f = self.section4.frame;
    f.origin.y = self.view.bounds.size.height - f.size.height;
    f.origin.x = 0;
    f.size.width = self.view.bounds.size.width;
    self.section4.frame = f;
    
    long userId = [LoginManager sharedInstance].loginInfo.userId;
    _mUser = [[RealmDataSource sharedInstance] getUser:userId];
    if (_mUser) {
        if(!_qrData)
        {
            //inititalize qrdata
            _qrData = [self qrDataFromUser:_mUser];
        }else
        {
            [self updateQRDataFromUser:_mUser];
        }
        [self populateView];
    }
    
    [self.navigationController.navigationBar addSubview:topBar];
    [self.navigationController.navigationBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[topBar]-115-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topBar)]];
    [self.navigationController.navigationBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topBar]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topBar)]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [topBar removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height - keyboardSize.height;
        self.section4.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.section4.frame;
        f.origin.y = self.view.bounds.size.height - f.size.height;
        self.section4.frame = f;
    }];
}


#pragma mark - textfield movement
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_txtTransactionAmount]) {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
        double number = [text intValue] * [self getDecimalPointMultiplier];
        textField.text = [NSString stringWithFormat:[self getDecimalPointFormatter], number];
        [self textFieldDidChange:textField];
        return NO;
    }else if([textField isEqual:_txtTip])
    {
        switch (_qrData.tipType) {
            case percentageConvenienceFee:
            {
                [self setSuffixText:@"%" textField:textField];
                NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
                text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
                double number = [text intValue] % 100;
                textField.text = [NSString stringWithFormat:@"%.0lf", number];
                [self textFieldDidChange:textField];
                return NO;
            }
                break;
            case flatConvenienceFee:
            {
                [self setSuffixText:nil textField:textField];
                NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
                text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
                double number = [text intValue] * [self getDecimalPointMultiplier];
                textField.text = [NSString stringWithFormat:[self getDecimalPointFormatter], number];
                [self textFieldDidChange:textField];
                return NO;
            }
                break;
                
            case promptedToEnterTip:
            default:
                [self setSuffixText:nil textField:textField];
                textField.text = @"";
                textField.enabled = false;
                break;
        }
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [self updateUITotalAmount];
    _qrData.transactionAmount = _txtTransactionAmount.text.doubleValue;
    _qrData.tip = _txtTip.text.doubleValue;
}


#pragma mark - UI and Tips and Amount Calculation
- (void) populateView
{
    double totalTransactionMoney = 0;
    for (int i = 0; i < _mUser.transactions.count; i++) {
        Transaction* transaction = [_mUser.transactions objectAtIndex:i];
        totalTransactionMoney += transaction.transactionAmount + transaction.tipAmount;
    }
    _lblTotalDaily.text = [NSString stringWithFormat:@"%@ %@"
                           , [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]]
                           , [NSString stringWithFormat:[self getDecimalPointFormatter],totalTransactionMoney]
                           ];
    _lblTotalTransactions.text = [NSString stringWithFormat:@"%ld", _mUser.transactions.count];
    _lblCurrencyCode.text = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]];
    _lblCurrencyCode2.text = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]];
    _lblMerchantName.text = _mUser.name;
    _lblMerchantAddress.text = [NSString stringWithFormat:@"@%@", _mUser.city];
    [self setInitialAmountAndTip];
    [self updateUITotalAmount];
}

- (void) setInitialAmountAndTip
{
    _txtTransactionAmount.text = [NSString stringWithFormat:[self getDecimalPointFormatter], _qrData.transactionAmount];
    [self setAmountSectionEnable:YES];
    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            [self setSuffixText:@"%" textField:_txtTip];
            _txtTip.text = [NSString stringWithFormat:@"%.0lf", _qrData.tip];
            [self setTipSectionEnable:true];
            break;
        case flatConvenienceFee:
            [self setSuffixText:nil textField:_txtTip];
            _txtTip.text = [NSString stringWithFormat:[self getDecimalPointFormatter], _qrData.tip];
            [self setTipSectionEnable:true];
            break;
        case promptedToEnterTip:
        default:
            [self setSuffixText:nil textField:_txtTip];
            _txtTip.text = @"";
            [self setTipSectionEnable:false];
            break;
    }
}

- (void) updateUITotalAmount
{
    _lblTotal.text = [NSString stringWithFormat:[self getDecimalPointFormatter], [self calculateTotalAmount]];
}

- (void) updateTipTypeButtonAndResetTipField
{
    //update the button
    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            [_btnTipType setTitle:@"Percent" forState:UIControlStateNormal];
            break;
        case flatConvenienceFee:
            [_btnTipType setTitle:@"Fixed" forState:UIControlStateNormal];
            break;
        case promptedToEnterTip:
            [_btnTipType setTitle:@"Prompt" forState:UIControlStateNormal];
            break;
        default:
            [_btnTipType setTitle:@"NA" forState:UIControlStateNormal];
            break;
    }
    
    //update the tiptype
    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            [self setSuffixText:@"%" textField:_txtTip];
        case flatConvenienceFee:
            [self setSuffixText:nil textField:_txtTip];
            _txtTip.text = @"0";
            [self textField:_txtTip shouldChangeCharactersInRange:NSMakeRange(0, 1) replacementString:@"0"];
            [self setTipSectionEnable:true];
            break;
        case promptedToEnterTip:
        default:
            [self setSuffixText:nil textField:_txtTip];
            _txtTip.text = @"";
            [self setTipSectionEnable:false];
            break;
    }
}

#pragma mark - UI helper
- (void)setSuffixText:(NSString *)suffix textField:(UITextField*) textField
{
    UILabel* existingLabel = [textField viewWithTag:992641];
    if (!suffix) {
        [textField setRightView:nil];
        return;
    }
    if (!existingLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 992641;
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName:textField.font.fontName size:textField.font.pointSize]];
        [label setTextColor:textField.textColor];
        [label setAlpha:.5];
        existingLabel = label;
    }
    
    [existingLabel setText:suffix];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:suffix attributes:@{NSFontAttributeName: existingLabel.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){existingLabel.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize suffixSize = rect.size;
    existingLabel.frame = CGRectMake(0, 0, suffixSize.width, textField.frame.size.height);
    
    [textField setRightView:existingLabel];
    [textField setRightViewMode:UITextFieldViewModeAlways];
}

- (void) setAmountSectionEnable:(BOOL) bEnable
{
    _txtTransactionAmount.enabled = bEnable;
    if (!bEnable) {
        _amountSection.backgroundColor = [ColorManager sharedInstance].textFieldColor;
    }else
    {
        _amountSection.backgroundColor = [UIColor whiteColor];
    }
}

- (void) setTipSectionEnable:(BOOL) bEnable
{
    _txtTip.enabled = bEnable;
    if (!bEnable) {
        _tipSection.backgroundColor = [ColorManager sharedInstance].textFieldColor;
    }else
    {
        _tipSection.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - helper

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    DialogViewController* dialogVC = [DialogViewController new];
    dialogVC.dialogMessage = message;
    dialogVC.positiveResponse = @"OK";
    [dialogVC showDialogWithContex:self
                      withYesBlock:^(DialogViewController* dialog){
                      } withNoBlock:^(DialogViewController* dialog){
                      }];
}

- (QRData*) qrDataFromUser:(User*) user
{
    QRData* qrData = [QRData new];
    qrData.merchantCode = user.code;
    qrData.merchantName = user.name;
    qrData.merchantCity = user.city;
    qrData.merchantCountryCode = user.countryCode;
    qrData.merchantCategoryCode = user.categoryCode;
    qrData.merchantIdentifierVisa02 = user.identifierVisa02;
    qrData.merchantIdentifierVisa03 = user.identifierVisa03;
    qrData.merchantIdentifierMastercard04 = user.identifierMastercard04;
    qrData.merchantIdentifierMastercard05 = user.identifierMastercard05;
    qrData.merchantIdentifierNPCI06 = user.identifierNPCI06;
    qrData.merchantIdentifierNPCI07 = user.identifierNPCI07;
    qrData.merchantStoreId = user.storeId;
    qrData.merchantTerminalNumber = user.terminalNumber;
    qrData.merchantMobile = user.mobile;
    qrData.currencyNumericCode = user.currencyNumericCode;
    qrData.transactionAmount = 0;
    qrData.tipType = unknownTipConvenienceIndicator;
    qrData.tip = 0;
    return qrData;
}

- (void) updateQRDataFromUser:(User*) user
{
    _qrData.merchantName = user.name;
    _qrData.merchantCity = user.city;
    _qrData.merchantCountryCode = user.countryCode;
    _qrData.merchantIdentifierMastercard04 = user.identifierMastercard04;
    _qrData.merchantMobile = user.mobile;
    if (![_qrData.currencyNumericCode isEqualToString:user.currencyNumericCode]) {
        _qrData.currencyNumericCode = user.currencyNumericCode;
        _qrData.transactionAmount = 0;
        _qrData.tip = 0;
    }
}

- (double) calculateTotalAmount
{
    double totalAmount = 0;
    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            totalAmount = _txtTransactionAmount.text.doubleValue*(1+_txtTip.text.doubleValue/100.0);
            break;
        case flatConvenienceFee:
            totalAmount = _txtTransactionAmount.text.doubleValue + _txtTip.text.doubleValue;
            break;
        case promptedToEnterTip:
            totalAmount = _txtTransactionAmount.text.doubleValue + _txtTip.text.doubleValue;
            break;
        default:
            totalAmount = _txtTransactionAmount.text.doubleValue + _txtTip.text.doubleValue;
            break;
    }
    return totalAmount;
}

- (NSString*) getDecimalPointFormatter
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    return formatString;
}

- (double) getDecimalPointMultiplier
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    return 1.0/pow(10, decimalPoint);
}

#pragma mark - Actions

- (IBAction)chooseTipType:(id)sender {
    TipTypeDialogViewController* dvg = [TipTypeDialogViewController new];
    dvg.dialogHeight = 260;
    dvg.positiveResponse = @"Select";
    dvg.negativeResponse = @"Cancel";
    dvg.tipType = _qrData.tipType;
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     TipTypeDialogViewController* cardChooser = (TipTypeDialogViewController*) dialog;
                     _qrData.tipType = cardChooser.tipType;
                     _qrData.tip = 0;
                     [self updateTipTypeButtonAndResetTipField];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

- (IBAction)openTransactions:(id)sender {
    
    TransactionListViewController* transactionVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionListViewController"];
    [self.navigationController pushViewController:transactionVC animated:YES];
}

- (IBAction)generateQRCode:(id)sender {
    PushPaymentData* paymentData = [PushPaymentData new];
    //version 01
    paymentData.payloadFormatIndicator = @"01";
    //11 static if transaction amount is not provided else 12 (dynamic)
    if (_qrData.transactionAmount == 0) {
        paymentData.pointOfInitiationMethod = @"11";
    }else
    {
        paymentData.pointOfInitiationMethod = @"12";
        paymentData.transactionAmount = [NSString stringWithFormat:[self getDecimalPointFormatter], _qrData.transactionAmount];
    }
    paymentData.merchantName = _qrData.merchantName;
    paymentData.merchantCity = _qrData.merchantCity;
    paymentData.countryCode = _qrData.merchantCountryCode;
    paymentData.merchantCategoryCode = _qrData.merchantCategoryCode;
    if(_qrData.merchantIdentifierVisa02) paymentData.merchantIdentifierVisa02 = _qrData.merchantIdentifierVisa02;
    if(_qrData.merchantIdentifierVisa03) paymentData.merchantIdentifierVisa03 = _qrData.merchantIdentifierVisa03;
    if(_qrData.merchantIdentifierMastercard04) paymentData.merchantIdentifierMastercard04 = _qrData.merchantIdentifierMastercard04;
    if(_qrData.merchantIdentifierMastercard05) paymentData.merchantIdentifierMastercard05 = _qrData.merchantIdentifierMastercard05;
    if(_qrData.merchantIdentifierNPCI06) paymentData.merchantIdentifierNPCI06 = _qrData.merchantIdentifierNPCI06;
    if(_qrData.merchantIdentifierNPCI07) paymentData.merchantIdentifierNPCI07 = _qrData.merchantIdentifierNPCI07;

    switch (_qrData.tipType) {
        case percentageConvenienceFee:
            paymentData.tipOrConvenienceIndicator = @"03";
            paymentData.valueOfConvenienceFeePercentage = [NSString stringWithFormat:@"%.0f", _qrData.tip];
            break;
        case flatConvenienceFee:
            paymentData.tipOrConvenienceIndicator = @"02";
            paymentData.valueOfConvenienceFeeFixed = [NSString stringWithFormat:[self getDecimalPointFormatter], _qrData.tip];
            break;
        case promptedToEnterTip:
            paymentData.tipOrConvenienceIndicator = @"01";
            break;
        default:
            break;
    }
    paymentData.transactionCurrencyCode = _qrData.currencyNumericCode;
    if (_qrData.merchantStoreId
        || _qrData.merchantTerminalNumber
        || _qrData.merchantMobile) {
        AdditionalData* additionalData = [AdditionalData new];
        if(_qrData.merchantStoreId)additionalData.storeId = _qrData.merchantStoreId;
        if(_qrData.merchantTerminalNumber)additionalData.terminalId = _qrData.merchantTerminalNumber;
        if(_qrData.merchantMobile)additionalData.mobileNumber = _qrData.merchantMobile;
        paymentData.additionalData = additionalData;
    }
    MPQRError* error;
    NSString* strGen = [paymentData generatePushPaymentString:&error];
    if (error) {
        [self showAlertWithTitle:@"Error Generating Data" message:[NSString stringWithFormat:@"Error generating data, %@", error.getString]];
    }else
    {
        QRDisplayViewController* qrVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QRDisplayViewController"];
        qrVC.strQRCode = strGen;
        qrVC.qrData = _qrData;
        [self.navigationController pushViewController:qrVC animated:YES];
    }
    
}

- (void) btnSettingPressed
{
    SettingViewController* settingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void) btnLogoutPressed
{
    DialogViewController* dvg = [DialogViewController new];
    dvg.dialogMessage = @"Are you sure you want to logout?";
    dvg.positiveResponse = @"YES";
    dvg.negativeResponse = @"CANCEL";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     
                     NSString* strAccessCode = [LoginManager sharedInstance].loginInfo.accessCode;
                     [[MPQRService sharedInstance] logoutWithParameters:[[LogoutRequest alloc] initWithAccessCode:strAccessCode]
                                                                success:^(LoginResponse* response){
                                                                    
                                                                    RLMResults<User*> *users = [User allObjects];
                                                                    for (int i = 0; i < users.count; i++) {
                                                                        User* user = [users objectAtIndex:i];
                                                                        NSLog(@"users name = %@", user.name);
                                                                    }
                                                                    NSLog(@"user count = %ld",users.count);
                                                                    [[RealmDataSource sharedInstance] deleteUser:[LoginManager sharedInstance].loginInfo.userId];
                                                                    [LoginManager sharedInstance].loginInfo = nil;
                                                                    
                                                                    LoginViewController* loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                                                    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
                                                                    
                                                                } failure:^(NSError* error){
                                                                    
                                                                }];
                     

                     
                     
                     
                     
                 } withNoBlock:^(DialogViewController* dialog){
                 }];
}

@end
