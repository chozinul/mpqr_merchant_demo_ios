//
//  GenericInputDialogViewController.m
//  MPQRMerchant
//
//  Created by Muchamad Chozinul Amri on 7/11/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "GenericInputDialogViewController.h"
#import "ColorManager.h"

@interface GenericInputDialogViewController ()

@end

@implementation GenericInputDialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void) setupHeader:(UIView*) headerView
{
    headerView.backgroundColor = [UIColor clearColor];
}


- (void) setupBody:(UIView*) bodyView
{
    bodyView.backgroundColor = [UIColor whiteColor];
    
    //add Title
    UILabel* lblTitle = [UILabel new];
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    lblTitle.text = self.dialogTitle;
    lblTitle.numberOfLines = 0;
    lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.font = [UIFont boldSystemFontOfSize:18];
    [bodyView addSubview:lblTitle];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblTitle]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblTitle)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[lblTitle(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblTitle)]];
    
    
    //add Title
    UILabel* lblBody = [UILabel new];
    lblBody.translatesAutoresizingMaskIntoConstraints = NO;
    lblBody.text = self.dialogDescription;
    lblBody.numberOfLines = 0;
    lblBody.lineBreakMode = NSLineBreakByWordWrapping;
    lblBody.textAlignment = NSTextAlignmentLeft;
    lblBody.font = [UIFont systemFontOfSize:14];
    [bodyView addSubview:lblBody];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblBody]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblTitle][lblBody(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody, lblTitle)]];
    
    //add pin txtfield
    UITextField* pinTextField = [UITextField new];
    pinTextField.translatesAutoresizingMaskIntoConstraints = NO;
    pinTextField.secureTextEntry = NO;
    pinTextField.text = _strValue;
    [pinTextField addTarget:self
                     action:@selector(textFieldDidChange:)
           forControlEvents:UIControlEventEditingChanged];
    [bodyView addSubview:pinTextField];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pinTextField]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pinTextField)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lblBody]-10-[pinTextField(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody, pinTextField)]];
    
    //add line below input
    UIView* line = [UIView new];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [bodyView addSubview:line];
    line.backgroundColor = [ColorManager sharedInstance].lineDevider;
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[line]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pinTextField][line(1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line, pinTextField)]];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    _strValue = textField.text;
}
@end
