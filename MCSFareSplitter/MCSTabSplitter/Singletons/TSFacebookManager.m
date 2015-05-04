//
//  TSFacebookController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSFacebookManager.h"

#import "TSTabUser.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "TSNotificationManager.h"
#import "TSDefinitions.h"
#import "TSUser.h"

@interface TSFacebookManager () <FBSDKLoginButtonDelegate>

@end

@implementation TSFacebookManager

static TSFacebookManager *sharedController = nil;

+ (id)sharedController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[super allocWithZone:NULL]init];
    });
    return sharedController;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [TSFacebookManager sharedController];
}

-(FBSDKLoginButton *)facebookLoginButton
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    
    [loginButton addTarget:self action:@selector(logInOutAttempt) forControlEvents:UIControlEventTouchUpInside];
    
    loginButton.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    loginButton.readPermissions = @[@"email", @"user_friends"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    return loginButton;
}

-(void)requestUserFromFacebookWithUserBlock:(void(^)(BOOL, TSTabUser *)) userBlock
{
    [self.delegate willLogin];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Reachability *reachability = [Reachability reachabilityWithHostName:@"www.facebook.com"];
        
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        
        if(netStatus != NotReachable)
        {
            if([FBSDKAccessToken currentAccessToken])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSString *userFirstName = [result objectForKey:@"first_name"];
                             NSString *userMiddleName = [result objectForKey:@"middle_name"];
                             NSString *userLastName = [result objectForKey:@"last_name"];
                             NSString *userEmail = [result objectForKey:@"email"];
                             
                             NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [[FBSDKAccessToken currentAccessToken] userID]];
                             UIImage *userProfilePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userImageURL]]];
                             
                             TSTabUser *user = [[TSTabUser alloc]initWithEmail:userEmail withFirstName:userFirstName withMiddleName:userMiddleName withLastName:userLastName userType:[TSTabUser TSUserTypeFacebook]];
                             user.profilePic = userProfilePic;
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 userBlock(YES, user);
                             });
                             
                         }
                         else{
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 userBlock(NO, nil);
                             });
                             NSLog(@"%@",error.localizedDescription);
                         }
                     }];
                });
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                userBlock(NO, nil);
                
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                
                [TSNotificationManager alertViewWithTitle:@"Facebook unreachable"
                                       andMessage:@"Sorry, there was a problem trying to reach Facebook. You might be connected to a network with restricted Facebook access"
                            withCancelButtonTitle:@"Cancel" withOtherActions:@[[UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
                    [self requestUserFromFacebookWithUserBlock:userBlock];
                }]]
                               fromViewController:delegate.window.rootViewController];
            });
        }
    });
}

-(void)logInOutAttempt
{
    if(![FBSDKAccessToken currentAccessToken])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate willLogin];
        });
    }
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if(!error)
    {
        [[TSFacebookManager sharedController] requestUserFromFacebookWithUserBlock:^(BOOL success, TSTabUser *user){
            if(success)
            {
                [TSUser sharedUser].user = user;
                
                [self.delegate loginWithSuccess:success];
                
                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                [delegate.window.rootViewController performSegueWithIdentifier:@"loginSegue" sender:delegate.window.rootViewController];
            }
        }];
    }
    else
    {
        [self.delegate loginWithSuccess:NO];
    }
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [self.delegate didLogout];
}

@end