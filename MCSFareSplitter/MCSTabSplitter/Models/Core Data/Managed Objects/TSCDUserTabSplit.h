//
//  TSCDUserTabSplit.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/5/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDItem, TSCDTab, TSCDUser;

@interface TSCDUserTabSplit : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSNumber * initialAmount;
@property (nonatomic, retain) NSNumber * userTabType;
@property (nonatomic, retain) TSCDTab *tab;
@property (nonatomic, retain) TSCDUser *user;
@property (nonatomic, retain) NSSet *items;
@end

@interface TSCDUserTabSplit (CoreDataGeneratedAccessors)

- (void)addItemsObject:(TSCDItem *)value;
- (void)removeItemsObject:(TSCDItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
