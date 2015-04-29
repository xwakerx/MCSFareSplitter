//
//  FSUser.m
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSUser.h"

@implementation TSUser

+ (TSUser *)sharedUser
{
    static TSUser *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[self alloc] init];
    });
    return sharedUser;
}

-(void)updateUserWithFirstName:(NSString *)firstName withMiddleName:(NSString *)middleName withLastName:(NSString *)lastName withEmail:(NSString *)email withCompletionBlock:(void(^)(BOOL success, NSError *error))completion
{
    //TODO - Call WS
    //When done if success
    
    self.user.firstName = firstName;
    self.user.middleName = middleName;
    self.user.lastName = lastName;
    self.user.email = email;
    
    completion(YES, nil);
    
    //If failure  completion(NO, error);
}
-(void)updateUserProfilePic:(UIImage *)profilePic withCompletionBlock:(void(^)(BOOL success, NSError *error))completion
{
    //TODO - Call WS
    //When done if success
    
    self.user.profilePic = profilePic;
    
    completion(YES, nil);
    
    //If failure  completion(NO, error);
}

@end
