//
//  TSFacebookController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSFacebookController.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "TSTabUser.h"

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


-(FBSDKLoginButton *)facebookLoginButton
{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    loginButton.readPermissions = @[@"email", @"user_friends"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(profileUpdated) name:FBSDKProfileDidChangeNotification object:nil];
    
    return loginButton;
}

-(void)requestUserFromFacebookWithUserBlock:(void(^)(BOOL, TSTabUser *)) userBlock
{
    if([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSString *userFirstName = [result objectForKey:@"first_name"];
                 NSString *userMiddleName = [result objectForKey:@"middle_name"];
                 NSString *userLastName = [result objectForKey:@"last_name"];
                 NSString *userEmail = [result objectForKey:@"email"];
                 
                 NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [[FBSDKAccessToken currentAccessToken] userID]];
//                 UIImage *userProfilePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userImageURL]]];
                 
                 TSTabUser *user = [[TSTabUser alloc]initWithEmail:userEmail withFirstName:userFirstName withMiddleName:userMiddleName withLastName:userLastName userType:[TSTabUser TSUserTypeFacebook]];
                 user.profilePic = userImageURL;
                 
                 userBlock(YES, user);
             }
             else{
                 userBlock(NO, nil);
                 NSLog(@"%@",error.localizedDescription);
             }
         }];
    }
}

-(void)requestUserFriendsFromFacebookWithFriendsBlock:(void(^)(BOOL, NSArray *)) friendsBlock
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/taggable_friends" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSMutableArray *friends = [NSMutableArray array];
             for (NSDictionary *friend in [result objectForKey:@"data"])
             {
                 NSString *friendFirstName = [friend objectForKey:@"first_name"];
                 NSString *friendMiddleName = [friend objectForKey:@"middle_name"];
                 NSString *friendLastName = [friend objectForKey:@"last_name"];
                 NSString *friendEmail = [friend objectForKey:@"email"];
                 
                 TSTabUser *user = [[TSTabUser alloc]initWithEmail:friendEmail withFirstName:friendFirstName withMiddleName:friendMiddleName withLastName:friendLastName userType:[TSTabUser TSUserTypeFacebook]];
                 
                 [friends addObject:user];

             }
             
             friendsBlock(YES, friends);
         }
         else{
             friendsBlock(NO, nil);
             NSLog(@"%@",error.localizedDescription);
         }
     }];
}

-(void)profileUpdated
{
    
}

@end