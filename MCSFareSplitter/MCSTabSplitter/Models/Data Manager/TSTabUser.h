//
//  FSBillUser.h
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@class TSUserTabSplit;

@interface TSTabUser : NSObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) UIImage *profilePic;
@property (nonatomic, strong) NSNumber *userType;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSArray *splitTabs;
//TODO Deposit methods
//@property (nonatomic) NSArray *depositMethods;
//prefered deposit
@property (nonatomic, readonly) NSNumber *owe;
@property (nonatomic, readonly) NSNumber *owed;

+(NSNumber *) TSUserTypeGhost;
+(NSNumber *) TSUserTypeFacebook;
+(NSNumber *) TSUserTypeContacts;
+(NSNumber *) TSUserTypeAction;

- (id) initGhostUserWithMail:(NSString *) email;
- (id) initActionUserWithMail:(NSString *) email;
- (id) initWithEmail: (NSString *) email withFirstName:(NSString*) firstName withMiddleName:(NSString*) middleName withLastName:(NSString*) lastName userType:(NSNumber*) userType;
- (NSString *) fullName;
-(void)addSplitTab:(TSUserTabSplit *)splitTab;
@end
