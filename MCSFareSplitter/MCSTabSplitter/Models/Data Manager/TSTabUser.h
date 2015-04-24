//
//  FSBillUser.h
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTabUser : NSObject

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *profilePic;
@property (nonatomic) NSNumber *userType;
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *middleName;
@property (nonatomic) NSString *lastName;
//TODO Deposit methods
//@property (nonatomic) NSArray *depositMethods;
//prefered deposit
@property (nonatomic) NSNumber *owe;
@property (nonatomic) NSNumber *owed;

+(NSNumber *) TSUserTypeGhost;
+(NSNumber *) TSUserTypeFacebook;

- (id) initGhostUserWithMail:(NSString *) email;
- (NSString *) getFullName;

@end
