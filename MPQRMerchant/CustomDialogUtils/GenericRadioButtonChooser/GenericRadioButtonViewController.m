//
//  GenericRadioButtonViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Mastercard. All rights reserved.
//

#import "GenericRadioButtonViewController.h"
#import "GenericRadioButtonTableViewCell.h"
#import "ColorManager.h"

@import DLRadioButton;

@interface GenericRadioButtonViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* tableView;
}
@end

@implementation GenericRadioButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overriden function

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
    
    UIView* line = [UIView new];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:line];
    line.backgroundColor = [ColorManager sharedInstance].lineDevider;
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[line]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView][line(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line, tableView)]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GenericRadioButtonTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GenericRadioButtonTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GenericRadioButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"GenericRadioButtonTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"GenericRadioButtonTableViewCell"];
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
    _selectedIndex = (int)indexPath.row;
    [tableView reloadData];
}


#pragma mark - Configure Cell
- (void) configureCell:(GenericRadioButtonTableViewCell*) cell forIndexPath:(NSIndexPath*) indexPath
{
    NSDictionary* dict = [_dataSource objectAtIndex:indexPath.row];
    cell.lblName.text = [dict objectForKey:@"name"];
    
    cell.radioValue.userInteractionEnabled = false;
    cell.radioValue.iconSize = 25;
    cell.radioValue.iconStrokeWidth = 3;
    cell.radioValue.indicatorSize = 10;
    
    if (indexPath.row == _selectedIndex) {
        cell.radioValue.iconColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioValue.indicatorColor = [ColorManager sharedInstance].radioButtonSelectedColor;
        cell.radioValue.selected = TRUE;
    }else{
        cell.radioValue.iconColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioValue.indicatorColor = [ColorManager sharedInstance].radioButtonUnselectedColor;
        cell.radioValue.selected = FALSE;
    }
    
}

@end
