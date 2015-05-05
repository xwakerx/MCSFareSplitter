//
//  TSCDTransaction.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/5/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDTab, TSCDUser;

@interface TSCDTransaction : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) TSCDUser *destination;
@property (nonatomic, retain) TSCDUser *source;
@property (nonatomic, retain) TSCDTab *tab;

@end
