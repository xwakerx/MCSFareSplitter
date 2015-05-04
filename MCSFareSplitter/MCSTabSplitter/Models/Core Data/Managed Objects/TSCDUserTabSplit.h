//
//  TSCDUserTabSplit.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDTab, TSCDUser;

@interface TSCDUserTabSplit : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSNumber * initialAmount;
@property (nonatomic, retain) NSNumber * userTabType;
@property (nonatomic, retain) TSCDTab *tab;
@property (nonatomic, retain) TSCDUser *user;

@end
