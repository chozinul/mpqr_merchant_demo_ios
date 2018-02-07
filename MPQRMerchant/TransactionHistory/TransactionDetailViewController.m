//
//  TransactionDetailViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 27/10/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "Transaction.h"
#import "CurrencyFormatter.h"

@import MasterpassQRCoreSDK;

@interface TransactionDetailViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end

@implementation TransactionDetailViewCell

@end

@interface TransactionDetailViewController ()
{
    NSArray* data;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblTip;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end

@implementation TransactionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblTotal.text = [NSString stringWithFormat:@"%@ %@"
                      , [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:self.transaction.currencyNumericCode]]
                      , [NSString stringWithFormat:[self getDecimalPointFormatter:self.transaction.currencyNumericCode], _transaction.transactionAmount + _transaction.tipAmount]];
    
    _lblTip.text = [NSString stringWithFormat:@"%@ %@"
                    , [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:self.transaction.currencyNumericCode]]
                    , [NSString stringWithFormat:[self getDecimalPointFormatter: self.transaction.currencyNumericCode], self.transaction.tipAmount]];
    _lblDate.text = [self.transaction getFormattedTransactionDate];
    
    data = @[@{@"title":@"MERCHANT NAME",
               @"content":self.transaction.merchantName},
             @{@"title":@"INVOICE NUMBER",
               @"content":self.transaction.invoiceNumber},
             @{@"title":@"REFERENCE ID",
               @"content":self.transaction.referenceId}
             ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionDetailViewCell" forIndexPath:indexPath];
    NSDictionary* dict = [data objectAtIndex:indexPath.row];
    cell.lblTitle.text = [dict objectForKey:@"title"];
    cell.lblContent.text = [dict objectForKey:@"content"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 70;
}

- (NSString*) getDecimalPointFormatter:(NSString*) currencyNumericCode
{
    NSString* alphaCode = [CurrencyEnumLookup getAlphaCode:[CurrencyEnumLookup enumFor:currencyNumericCode]];
    int decimalPoint = [CurrencyEnumLookup getDecimalPointOfAlphaCode:alphaCode];
    NSString* formatString = [NSString stringWithFormat:@"%%.%dlf",decimalPoint];
    return formatString;
}

@end
