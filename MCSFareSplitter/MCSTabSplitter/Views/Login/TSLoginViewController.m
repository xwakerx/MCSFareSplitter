//
//  TSLoginViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSLoginViewController.h"

#import "TSFacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TSLoginViewController () <TSFacebookManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (nonatomic, strong ) FBSDKLoginButton *loginButton;

@property (nonatomic, strong) UIView *overlay;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[TSFacebookManager sharedController] setDelegate:self];
    
    self.loginButton = [[TSFacebookManager sharedController] facebookLoginButton];
    self.loginButton.center = CGPointMake(self.view.center.x, 450);
    
    [self.view addSubview:self.loginButton];
    
    self.btnLogin.center = CGPointMake(self.view.center.x, 500);
    
    //    self.btnLogin.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    if(self.loginButton.isHidden && ![FBSDKAccessToken currentAccessToken])
    {
        self.loginButton.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logoutSegue:(UIStoryboardSegue *)segue{}

-(void)showLoadingOverlay
{
    if(!self.overlay)
    {
        self.overlay = [[UIView alloc]init];
    }
    self.overlay.frame = self.view.frame;
    
    self.overlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]init];
    self.activityIndicator.center = self.overlay.center;
    
    [self.overlay addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
    
    [self.view addSubview:self.overlay];
}

-(void)hideLoadingOverlay
{
    [self.activityIndicator stopAnimating];
    [self.overlay removeFromSuperview];
}

-(void)loginWithSuccess:(BOOL)success
{
    [self hideLoadingOverlay];
}

-(void)didLogout
{
    [self hideLoadingOverlay];
}

-(void)willLogin
{
    [self showLoadingOverlay];
}

@end
