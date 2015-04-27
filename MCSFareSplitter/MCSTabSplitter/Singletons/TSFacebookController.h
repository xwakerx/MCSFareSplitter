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

@interface TSFacebookController : NSObject

+ (id)sharedController;

-(FBSDKLoginButton *)facebookLoginButton;
-(void)requestUserFromFacebookWithUserBlock:(void(^)(BOOL, TSTabUser *)) userBlock;

@end
