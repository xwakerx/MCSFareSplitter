//
//  TSLoginViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSLoginViewController.h"

#import "TSFacebookController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface TSLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(![FBSDKAccessToken currentAccessToken])
    {
        FBSDKLoginButton *loginButton = [[TSFacebookController sharedController] facebookLoginButton];
        loginButton.center = CGPointMake(self.view.center.x, 450);
        
        [self.view addSubview:loginButton];
    }
    
    self.btnLogin.center = CGPointMake(self.view.center.x, 500);
    
//    self.btnLogin.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logoutSegue:(UIStoryboardSegue *)segue{}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
