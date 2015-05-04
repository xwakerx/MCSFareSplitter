//
//  TSCDTransaction.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDUser;

@interface TSCDTransaction : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) TSCDUser *destination;
@property (nonatomic, retain) TSCDUser *source;

@end
