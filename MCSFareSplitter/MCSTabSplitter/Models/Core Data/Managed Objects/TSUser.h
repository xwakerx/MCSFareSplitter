//
//  TSUser.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSAccount, TSUserTabSplit;

@interface TSUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * profilePicUrl;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * userType;
@property (nonatomic, retain) NSSet *accounts;
@property (nonatomic, retain) NSSet *splits;
@end

@interface TSUser (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(TSAccount *)value;
- (void)removeAccountsObject:(TSAccount *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (void)addSplitsObject:(TSUserTabSplit *)value;
- (void)removeSplitsObject:(TSUserTabSplit *)value;
- (void)addSplits:(NSSet *)values;
- (void)removeSplits:(NSSet *)values;

@end
