//
//  TSFacebookController.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@class FBSDKLoginButton;
@class TSTabUser;

@protocol TSFacebookManagerDelegate <NSObject>

@optional
-(void)loginWithSuccess:(BOOL)login;
-(void)didLogout;
-(void)willLogin;

@end

@interface TSFacebookManager : NSObject

@property (nonatomic, assign) id <TSFacebookManagerDelegate> delegate;

+ (id)sharedController;

-(FBSDKLoginButton *)facebookLoginButton;
-(void)requestUserFromFacebookWithUserBlock:(void(^)(BOOL, TSTabUser *)) userBlock;

@end
