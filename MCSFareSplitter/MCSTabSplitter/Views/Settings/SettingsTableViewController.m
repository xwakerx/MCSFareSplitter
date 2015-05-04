//
//  SettingsTableViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "TSFacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *tvcLogout;

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    FBSDKLoginButton *loginButton = [[TSFacebookManager sharedController] facebookLoginButton];
    loginButton.delegate = self;
    loginButton.center = CGPointMake(self.tvcLogout.frame.size.width/2, self.tvcLogout.frame.size.height/2);
    [self.tvcLogout addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [self performSegueWithIdentifier:@"logoutSegue" sender:self];
}

@end
