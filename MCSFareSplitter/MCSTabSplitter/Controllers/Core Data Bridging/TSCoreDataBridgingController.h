//
//  CoreDataBridgingController.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSAccount;
@class TSCDAccount;
@class TSItem;
@class TSCDItem;
@class TSTab;
@class TSCDTab;
@class TSTransaction;
@class TSCDTransaction;
@class TSTabUser;
@class TSCDUser;
@class TSUserTabSplit;
@class TSCDUserTabSplit;

@interface TSCoreDataBridgingController : NSObject

+(TSAccount *)localAccountFromCoreDataAccount:(TSCDAccount *)coreDataAccount;
+(TSItem *)localItemFromCoreDataItem:(TSCDItem *)coreDataItem;
+(TSTab *)localTabFromCoreDataTab:(TSCDTab *)coreDataTab;
+(TSTransaction *)localTransactionFromCoreDataTransaction:(TSCDTransaction *)coreDataTransaction;
+(TSTabUser *)localUserFromCoreDataUser:(TSCDUser *)coreDataUser;
+(TSUserTabSplit *)localSplitFromCoreDataSplit:(TSCDUserTabSplit *)coreDataSplit;

@end
