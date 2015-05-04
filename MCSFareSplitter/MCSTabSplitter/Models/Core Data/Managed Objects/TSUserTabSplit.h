//
//  TSUserTabSplit.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface TSUserTabSplit : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSNumber * initialAmount;
@property (nonatomic, retain) NSNumber * userTabType;
@property (nonatomic, retain) NSManagedObject *tab;
@property (nonatomic, retain) NSManagedObject *user;

@end
