//
//  TSFacebookController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSFacebookController.h"

#import "TSTabUser.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "TSNotificationManager.h"
#import "TSDefinitions.h"

@implementation TSFacebookController

+ (id)sharedController
{
    static TSFacebookController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc] init];
    });
    return sharedController;
}

-(instancetype)init
{
    [NSException raise:kTSSingletonException format:@"You can't call init in a singleton duh!"];
    return nil;
}

-(FBSDKLoginButton *)facebookLoginButton
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    loginButton.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    loginButton.readPermissions = @[@"email", @"user_friends"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(profileUpdated) name:FBSDKProfileDidChangeNotification object:nil];
    
    return loginButton;
}

-(void)requestUserFromFacebookWithUserBlock:(void(^)(BOOL, TSTabUser *)) userBlock
{
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

-(void)profileUpdated
{
    
}

@end
