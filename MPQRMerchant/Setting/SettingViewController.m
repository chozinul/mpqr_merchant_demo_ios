//
//  SettingViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "User.h"
#import "LoginManager.h"
#import "RealmDataSource.h"
#import "LoginResponse.h"
#import "Settings.h"
#import "GenericInputDialogViewController.h"
#import "CountryCode.h"
#import "GenericRadioButtonViewController.h"
#import "CreditCardFormatter.h"
#import "CreditCardInputViewController.h"
#import "CurrencyCode.h"

@import Realm;
@import MasterpassQRCoreSDK;

@interface SettingViewController ()
{
    NSMutableArray* dataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property User* mUser;

@end

@implementation SettingViewController

NSString * const kSettingMerchantName = @"MERCHANT NAME";
NSString * const kSettingCountry = @"COUNTRY";
NSString * const kSettingCity = @"CITY";
NSString * const kSettingMercantCategoryCode = @"MERCHANT CATEGORY CODE";
NSString * const kSettingCardNumber = @"CARD NUMBER";
NSString * const kSettingCurrency = @"CURRENCY";
NSString * const kSettingStoreId = @"STORE ID";
NSString * const kSettingTerminalId = @"TERMINAL ID";
NSString * const kSettingPhone = @"PHONE";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup data source

- (void) setupDataSource
{
    long userId = [LoginManager sharedInstance].loginInfo.userId;
    _mUser = [[RealmDataSource sharedInstance] getUser:userId];
    dataSource = [NSMutableArray arrayWithArray:
                  @[[Settings SettingWithTitle:kSettingMerchantName value:_mUser.name isEditable:YES],
                    [Settings SettingWithTitle:kSettingCountry value:_mUser.countryCode isEditable:YES],
                    [Settings SettingWithTitle:kSettingCity value:_mUser.city isEditable:YES],
                    [Settings SettingWithTitle:kSettingMercantCategoryCode value:_mUser.categoryCode isEditable:NO],
                    [Settings SettingWithTitle:kSettingCardNumber value:_mUser.identifierMastercard04 isEditable:YES],
                    [Settings SettingWithTitle:kSettingCurrency value:_mUser.currencyNumericCode isEditable:YES],
                    [Settings SettingWithTitle:kSettingStoreId value:_mUser.storeId isEditable:NO],
                    [Settings SettingWithTitle:kSettingTerminalId value:_mUser.terminalNumber isEditable:NO],
                    [Settings SettingWithTitle:kSettingPhone value:_mUser.mobile isEditable:YES]]];
}

- (void) replaceSettingFor:(Settings*) setting
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    if ([setting.title isEqualToString:kSettingMerchantName])_mUser.name = setting.value;
    if ([setting.title isEqualToString:kSettingCountry])
        _mUser.countryCode = setting.value;
    if ([setting.title isEqualToString:kSettingCity])_mUser.city = setting.value;
    if ([setting.title isEqualToString:kSettingMercantCategoryCode])_mUser.categoryCode = setting.value;
    if ([setting.title isEqualToString:kSettingCardNumber])
        _mUser.identifierMastercard04 = setting.value;
    if ([setting.title isEqualToString:kSettingCurrency])
        _mUser.currencyNumericCode = setting.value;
    if ([setting.title isEqualToString:kSettingStoreId])_mUser.storeId = setting.value;
    if ([setting.title isEqualToString:kSettingTerminalId])_mUser.terminalNumber = setting.value;
    if ([setting.title isEqualToString:kSettingPhone])_mUser.mobile = setting.value;
    [realm commitWriteTransaction];
    [self setupDataSource];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 60;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Settings* set = [dataSource objectAtIndex:indexPath.row];
    if (!set.isEditable) {
        return;
    }
    if ([set.title isEqualToString:kSettingMerchantName]) {
        [self modifyMerchantNameWithSetting:set];
    }
    if ([set.title isEqualToString:kSettingCountry]) {
        [self modifyCountryWithSetting:set];
    }
    if ([set.title isEqualToString:kSettingCity]) {
        [self modifyCityWithSetting:set];
    }
    if ([set.title isEqualToString:kSettingCardNumber]) {
        [self modifyCardWithSetting:set];
    }
    if ([set.title isEqualToString:kSettingCurrency]) {
        [self modifyCurrencyWithSetting:set];
    }
    if ([set.title isEqualToString:kSettingPhone]) {
        [self modifyPhoneWithSetting:set];
    }
    [tableView reloadData];
}


#pragma mark - Configure Cell
- (void) configureCell:(SettingTableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath
{
    Settings* set = [dataSource objectAtIndex:indexPath.row];
    
    cell.lblTitle.text = set.title;
    
    
    if ([set.title isEqualToString:kSettingCountry])
    {
        cell.lblDescription.text = [[CountryCode sharedInstance] getCountryOfCode:set.value];
    }else if([set.title isEqualToString:kSettingCardNumber])
    {
        NSString* strCreditCard = [CreditCardFormatter getFormattedCreditCardOfString:set.value];
        cell.lblDescription.text = strCreditCard;
    }else if([set.title isEqualToString:kSettingCurrency])
    {
        NSString* strCurrency = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:set.value]];
        cell.lblDescription.text = strCurrency;
    }else
    {
        cell.lblDescription.text = set.value;
    }
    
    if (set.isEditable) {
        cell.clickableIndicator.hidden = false;
    }else
    {
        cell.clickableIndicator.hidden = true;
    }
}

- (void) modifyMerchantNameWithSetting:(Settings*) set
{
    GenericInputDialogViewController* dvg = [GenericInputDialogViewController new];
    dvg.dialogTitle = @"Merchant Name";
    dvg.dialogDescription = @"Please enter name";
    dvg.strValue = set.value;
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     GenericInputDialogViewController* dialogVC = (GenericInputDialogViewController*) dialog;
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingMerchantName value:dialogVC.strValue isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

- (void) modifyCountryWithSetting:(Settings*) set
{
    NSArray* arrayCountry = [[CountryCode sharedInstance] getAllCountries];
    NSMutableArray* dataSource = [NSMutableArray array];
    int selectedIndex = 0;
    for (int i = 0; i < arrayCountry.count; i++) {
        NSString* strCountry = [arrayCountry objectAtIndex:i];
        NSString* strCode = [[CountryCode sharedInstance] getCodeOfCountry:strCountry];
        [dataSource addObject:@{@"name":strCountry, @"code":strCode}];
        if ([strCode isEqualToString:set.value]) {
            selectedIndex = i;
        }
    }
    
    GenericRadioButtonViewController* dvg = [GenericRadioButtonViewController new];
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    dvg.dialogHeight = self.view.bounds.size.height - 100;
    dvg.dataSource = dataSource;
    dvg.selectedIndex = selectedIndex;
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     GenericRadioButtonViewController* dialogVC = (GenericRadioButtonViewController*) dialog;
                     NSString* strCode = [[dataSource objectAtIndex:dialogVC.selectedIndex] objectForKey:@"code"];
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingCountry value:strCode isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

- (void) modifyCityWithSetting:(Settings*) set
{
    GenericInputDialogViewController* dvg = [GenericInputDialogViewController new];
    dvg.dialogTitle = @"City";
    dvg.dialogDescription = @"Please enter city";
    dvg.strValue = set.value;
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     GenericInputDialogViewController* dialogVC = (GenericInputDialogViewController*) dialog;
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingCity value:dialogVC.strValue isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

- (void) modifyCardWithSetting:(Settings*) set
{
    CreditCardInputViewController* dvg = [CreditCardInputViewController new];
    dvg.dialogTitle = @"Card Number";
    dvg.dialogDescription = @"Please enter card number";
    dvg.strValue = set.value;
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     CreditCardInputViewController* dialogVC = (CreditCardInputViewController*) dialog;
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingCardNumber value:dialogVC.strValue isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}


- (void) modifyCurrencyWithSetting:(Settings*) set
{
    NSArray* arrayCountry = [[CurrencyCode sharedInstance] getAllCountries];
    NSMutableArray* dataSource = [NSMutableArray array];
    int selectedIndex = 0;
    for (int i = 0; i < arrayCountry.count; i++) {
        NSString* strCurrency = [arrayCountry objectAtIndex:i];
        NSString* strCode = [[CurrencyCode sharedInstance] getCodeOfCountry:strCurrency];
        NSString* strAlphaCurrency = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:strCode]];
        [dataSource addObject:@{@"name":[NSString stringWithFormat:@"%@ - %@", strAlphaCurrency, strCurrency], @"code":strCode}];
        if ([strCode isEqualToString:set.value]) {
            selectedIndex = i;
        }
    }
    
    GenericRadioButtonViewController* dvg = [GenericRadioButtonViewController new];
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    dvg.dialogHeight = self.view.bounds.size.height - 100;
    dvg.dataSource = dataSource;
    dvg.selectedIndex = selectedIndex;
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     GenericRadioButtonViewController* dialogVC = (GenericRadioButtonViewController*) dialog;
                     NSString* strCode = [[dataSource objectAtIndex:dialogVC.selectedIndex] objectForKey:@"code"];
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingCurrency value:strCode isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}

- (void) modifyPhoneWithSetting:(Settings*) set
{
    GenericInputDialogViewController* dvg = [GenericInputDialogViewController new];
    dvg.dialogTitle = @"Phone Number";
    dvg.dialogDescription = @"Please enter phone number";
    dvg.strValue = set.value;
    dvg.positiveResponse = @"OK";
    dvg.negativeResponse = @"Cancel";
    [dvg showDialogWithContex:self.navigationController
                 withYesBlock:^(DialogViewController* dialog){
                     GenericInputDialogViewController* dialogVC = (GenericInputDialogViewController*) dialog;
                     [self replaceSettingFor:[Settings SettingWithTitle:kSettingPhone value:dialogVC.strValue isEditable:YES]];
                 } withNoBlock:^(DialogViewController* dialog){
                     
                 }];
}



@end
