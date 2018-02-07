//
//  TipTypeDialogViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 6/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "TipTypeDialogViewController.h"
#import "TipTypeChooserTableViewCell.h"
#import "ColorManager.h"

@import DLRadioButton;

@interface TipTypeDialogViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray* dataSource;
    UITableView* tableView;
}

@end

@implementation TipTypeDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource = @[
                   @{@"FLAT":[NSNumber numberWithInt:flatConvenienceFee]},
                   @{@"PERCENTAGE":[NSNumber numberWithInt:percentageConvenienceFee]},
                   @{@"PROMPT":[NSNumber numberWithInt:promptedToEnterTip]},
                   @{@"NONE":[NSNumber numberWithInt:unknownTipConvenienceIndicator]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) setupBody:(UIView*) bodyView
{
    bodyView.backgroundColor = [UIColor whiteColor];
    //add Title
    tableView = [[UITableView alloc] initWithFrame:bodyView.bounds];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [bodyView addSubview:tableView];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[tableView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tableView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipTypeChooserTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TipTypeChooserTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TipTypeChooserTableViewCell" bundle:nil] forCellReuseIdentifier:@"TipTypeChooserTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TipTypeChooserTableViewCell"];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary* dict = [dataSource objectAtIndex:indexPath.row];
    _tipType = [[dict allValues].firstObject intValue];
    [tableView reloadData];
}


#pragma mark - Configure Cell
- (void) configureCell:(TipTypeChooserTableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath
{
    NSDictionary* dict = [dataSource objectAtIndex:indexPath.row];
    TipConvenienceIndicator tipType = [[dict allValues].firstObject intValue];
    //configure radio button
    cell.radioDefault.userInteractionEnabled = false;
    cell.radioDefault.iconSize = 25;
    cell.radioDefault.iconStrokeWidth = 3;
    cell.radioDefault.indicatorSize = 10;
    
    if (_tipType == tipType) {
        cell.radioDefault.iconColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioDefault.indicatorColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioDefault.selected = TRUE;
    }else{
        cell.radioDefault.iconColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioDefault.indicatorColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioDefault.selected = FALSE;
    }
    
    //balance
    cell.title.text = [dict allKeys].firstObject;
    
}



@end
