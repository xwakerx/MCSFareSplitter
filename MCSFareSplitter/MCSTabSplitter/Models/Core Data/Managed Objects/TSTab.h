//
//  TSTab.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSTransaction, TSUserTabSplit;

@interface TSTab : NSManagedObject

@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSNumber * splitMethod;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * totalAmount;
@property (nonatomic, retain) TSTransaction *transactions;
@property (nonatomic, retain) NSSet *users;
@end

@interface TSTab (CoreDataGeneratedAccessors)

- (void)addUsersObject:(TSUserTabSplit *)value;
- (void)removeUsersObject:(TSUserTabSplit *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
