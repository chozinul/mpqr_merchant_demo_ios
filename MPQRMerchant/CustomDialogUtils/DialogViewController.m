//
//  DialogViewController.m
//  MPQRPayment
//
//  Created by Muchamad Chozinul Amri on 29/10/17.
//  Copyright © 2017 Muchamad Chozinul Amri. All rights reserved.
//

#import "DialogViewController.h"
#import "ColorManager.h"

@interface DialogViewController ()

@property DialogViewControllerCompletionBlock _Nullable completionBlockSuccess;
@property DialogViewControllerCompletionBlock _Nullable completionBlockFail;
@end

@implementation DialogViewController

- (nonnull id) init
{
    return [self initWithDialogMessage:@"" positiveResponse:@"OK" negativeResponse:nil dialogHeight:200];
}

- (nonnull id) initWithDialogMessage:(NSString*) dialogMessage positiveResponse:(NSString*) positiveResponse negativeResponse:(NSString*) negativeResponse dialogHeight:(int) dialogHeight
{
    if ((self = [super init])) {
        self.dialogMessage = dialogMessage;
        self.positiveResponse = positiveResponse;
        self.negativeResponse = negativeResponse;
        self.dialogHeight = dialogHeight?dialogHeight:200;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add container
    self.view.backgroundColor = [ColorManager sharedInstance].semiTransparentBackground;
    UIView* container = [UIView new];
    container.backgroundColor = [UIColor clearColor];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:container];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[container]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(container)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[container(%d)]",_dialogHeight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(container)]];

    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:0
                                     toItem:container
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    
    //add header
    UIView* headerView = [UIView new];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:headerView];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerView)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerView)]];
    [headerView addConstraint:[NSLayoutConstraint
                                  constraintWithItem:headerView
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:headerView
                                  attribute:NSLayoutAttributeWidth
                                  multiplier:(34.0 / 258.0)
                                  constant:0]];
    
    
    [self setupHeader:headerView];
    
    //add body
    UIView* bodyView = [UIView new];
    bodyView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:bodyView];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bodyView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bodyView)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[headerView][bodyView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(headerView, bodyView)]];
    
    [self setupBody:bodyView];
    
    //add footer
    UIView* footerView = [UIView new];
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:footerView];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footerView)]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bodyView][footerView(40)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footerView, bodyView)]];
    
    [self setupFooter:footerView];
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

- (void) showDialogWithContex:(UIViewController* _Nonnull) vc withYesBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) success withNoBlock:(nullable void (^)(DialogViewController* _Nonnull dialogVC)) fail
{
    _completionBlockFail = fail;
    _completionBlockSuccess = success;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext | UIModalPresentationFullScreen;
    [vc presentViewController:self animated:NO completion:nil];
}

#pragma mark - Setup UI
- (void) setupHeader:(UIView*) headerView
{
    headerView.backgroundColor = [UIColor clearColor];
}

- (void) setupBody:(UIView*) bodyView
{
    bodyView.backgroundColor = [UIColor whiteColor];
    //add text body
    UILabel* lblBody = [UILabel new];
    lblBody.translatesAutoresizingMaskIntoConstraints = NO;
    lblBody.text = self.dialogMessage;
    lblBody.numberOfLines = 0;
    lblBody.lineBreakMode = NSLineBreakByWordWrapping;
    lblBody.textAlignment = NSTextAlignmentCenter;
    [bodyView addSubview:lblBody];
    [bodyView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblBody]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblBody)]];
    [bodyView addConstraint:
     [NSLayoutConstraint constraintWithItem:bodyView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:0
                                     toItem:lblBody
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
}

- (void) setupFooter:(UIView*) footerView
{
    footerView.backgroundColor = [UIColor whiteColor];
    
    
    UIButton* btnYes = [UIButton buttonWithType:UIButtonTypeCustom];
    btnYes.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.positiveResponse) {
        [btnYes setTitle:self.positiveResponse forState:UIControlStateNormal];
    }else
    {
        btnYes.hidden = YES;
        btnYes.enabled = FALSE;
    }
    
    [btnYes setTitleColor:[ColorManager sharedInstance].textColor forState:UIControlStateNormal];
    [btnYes addTarget:self action:@selector(btnYesPressed) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnYes];
    
    UIButton* btnNo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNo.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.negativeResponse) {
        [btnNo setTitle:self.negativeResponse forState:UIControlStateNormal];
    }else
    {
        btnNo.hidden = YES;
        btnNo.enabled = FALSE;
    }
    
    [btnNo setTitleColor:[ColorManager sharedInstance].textColor forState:UIControlStateNormal];
    [btnNo addTarget:self action:@selector(btnNoPressed) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnNo];
    
    if (self.positiveResponse) {
        [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=10)-[btnNo(75)]-25-[btnYes(75)]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnYes, btnNo)]];
    }else
    {
        [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=10)-[btnYes(75)]-25-[btnNo(75)]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnYes, btnNo)]];
        
    }
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[btnYes]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnYes)]];
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[btnNo]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btnNo)]];
}

#pragma mark - Action
-(void) btnYesPressed{
    [self dismissViewControllerAnimated:YES completion:^(){
        _completionBlockSuccess(self);
    }];
    
}

- (void) btnNoPressed{
    [self dismissViewControllerAnimated:YES completion:^(){
        _completionBlockFail(self);
    }];
}

@end
