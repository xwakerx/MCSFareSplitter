//
//  TSCDTab.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDTransaction, TSCDUserTabSplit;

@interface TSCDTab : NSManagedObject

@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSNumber * splitMethod;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * totalAmount;
@property (nonatomic, retain) TSCDTransaction *transactions;
@property (nonatomic, retain) NSSet *users;
@end

@interface TSCDTab (CoreDataGeneratedAccessors)

- (void)addUsersObject:(TSCDUserTabSplit *)value;
- (void)removeUsersObject:(TSCDUserTabSplit *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
