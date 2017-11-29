//
//  TransactionListViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "TransactionListViewController.h"
#import "MPQRService.h"
#import "Transaction.h"
#import "UserManager.h"
#import "PaymentInstrument.h"
#import "TransactionDetailViewController.h"
#import "CurrencyFormatter.h"
#import "TransactionsRequest.h"
#import "LoginManager.h"
#import "LoginResponse.h"
#import "RealmDataSource.h"

@import Realm;

@interface TransactionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgviewStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblMoney;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;



@end

@implementation TransactionViewCell


@end

@interface TransactionListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblTotalTransactions;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalMoney;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property User* mUser;
@property NSArray* tableViewDataSource;
@end

@implementation TransactionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    long userId = [LoginManager sharedInstance].loginInfo.userId;
    _mUser = [[RealmDataSource sharedInstance] getUser:userId];
    
    NSMutableArray* arrayTransaction = [NSMutableArray array];
    double totalTransactionMoney = 0;
    for (int i = 0; i < _mUser.transactions.count; i++) {
        Transaction* transaction = [_mUser.transactions objectAtIndex:i];
        [arrayTransaction addObject:transaction];
        totalTransactionMoney += transaction.transactionAmount + transaction.tipAmount;
    }
    
    [arrayTransaction sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"transactionDate" ascending:NO]]];
    _tableViewDataSource = arrayTransaction;
    
    _lblTotalMoney.text = [NSString stringWithFormat:@"%@ %@"
                           , [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:_mUser.currencyNumericCode]]
                           , [NSString stringWithFormat:[self getDecimalPointFormatter:_mUser.currencyNumericCode],totalTransactionMoney]
                           ];
    _lblTotalTransactions.text = [NSString stringWithFormat:@"%ld", _mUser.transactions.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionViewCell" forIndexPath:indexPath];
    Transaction* trans = [_tableViewDataSource objectAtIndex:indexPath.row];
    cell.lblMerchant.text = trans.merchantName;
    cell.lblMoney.text = [NSString stringWithFormat:[self getDecimalPointFormatter:trans.currencyNumericCode],trans.transactionAmount + trans.tipAmount];
    cell.lblDate.text = [trans getFormattedTransactionDate];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 90;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Transaction* trans = [_tableViewDataSource objectAtIndex:indexPath.row];
    TransactionDetailViewController* tDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TransactionDetailViewController"];
    tDetailVC.transaction = trans;
    [self.navigationController pushViewController:tDetailVC animated:YES];
}

#pragma mark - Hepler
- (NSString*) getDecimalPointFormatter:(NSString*) numericCode
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:numericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    return formatString;
}
@end
