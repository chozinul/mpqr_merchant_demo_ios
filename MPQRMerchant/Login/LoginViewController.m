//
//  LoginViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 26/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "LoginViewController.h"
#import "MPQRService.h"
#import "LoginManager.h"
#import "User.h"
#import "PaymentInstrument.h"
#import "DialogViewController.h"
#import "LoginRequest.h"
#import "GetUserInfoRequest.h"
#import "UserManager.h"
#import "RealmDataSource.h"

@import MaterialTextField;

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accessCode;
@property (weak, nonatomic) IBOutlet MFTextField *pin;
@property (weak, nonatomic) IBOutlet UIView *section4;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    CGRect f = self.section4.frame;
    f.origin.y = self.view.bounds.size.height - f.size.height;
    f.origin.x = 0;
    f.size.width = self.view.bounds.size.width;
    self.section4.frame = f;
    
    [self setInitialAccesscode];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
- (IBAction)signIn:(id)sender {
    NSString* strAccessCode = _accessCode.text;
    NSString* strPin = _pin.text;
    
    if (![self isValidAccessCode:strAccessCode pin:strPin]) {
        DialogViewController* dialogVC = [DialogViewController new];
        dialogVC.dialogMessage = @"Invalid access code or pin, please enter a valid access code and 6 digit pin.";
        dialogVC.positiveResponse = @"OK";
        [dialogVC showDialogWithContex:self
                     withYesBlock:^(DialogViewController* dialog){
                     } withNoBlock:^(DialogViewController* dialog){
                     }];
        return;
    }
    
    
    LoginRequest* lRequest = [[LoginRequest alloc] initWithAccessCode:strAccessCode pin:strPin];
    
    [[MPQRService sharedInstance] loginWithParameters:lRequest
                                              success:^(LoginResponse* lResponse){
                                                  
                                                  [LoginManager sharedInstance].loginInfo = lResponse;
                                                  
                                                  GetUserInfoRequest* request = [[GetUserInfoRequest alloc] initWithAccessCode:strAccessCode];
                                                  [[MPQRService sharedInstance] getUserWithParameters:request
                                                                                              success:^(User* user){
                                                                                                  [[RealmDataSource sharedInstance] saveUser:user];
                                                                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                                                              } failure:^(NSError* error){
                                                                                                  [self showAlertWithTitle:@"User Not Found" message:@"Related user with this account is not found. Please try again later or contact our administrator."];
                                                                                              }];
                                                  
                                              } failure:^(NSError* error){
                                                  error = [self errorWithLocalizedDescription:@"Please enter a valid 6 digit pin."];
                                                  [self.pin setError:error animated:YES];
                                              }];
    
}

- (BOOL) isValidAccessCode:(NSString*) accessCode pin:(NSString*) pin
{
    if (accessCode.length == 0) {
        return false;
    }
    if (pin.length != 6) {
        return false;
    }
    return true;
}


#pragma mark - textfield movement
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

#pragma mark - MFTextField
- (void) setInitialAccesscode
{
    if (_accessCode.text.length == 0) {
        _accessCode.text = [LoginManager sharedInstance].lastUser;
    }
}

- (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription
{
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: localizedDescription};
    return [NSError errorWithDomain:@"MPQR Merchat Domain" code:505 userInfo:userInfo];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField != self.pin) {
        return YES;
    }
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (text.length > 6) {
        return NO;
    }else
    {
        return YES;
    }
}

#pragma mark - Helper

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    DialogViewController* dialogVC = [DialogViewController new];
    dialogVC.dialogMessage = message;
    dialogVC.positiveResponse = @"OK";
    [dialogVC showDialogWithContex:self
                      withYesBlock:^(DialogViewController* dialog){
                      } withNoBlock:^(DialogViewController* dialog){
                      }];
}

@end
