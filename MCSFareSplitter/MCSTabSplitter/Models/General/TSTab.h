//
//  TSTab.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSCurrency;

typedef enum
{
    TSSplitEqually,
    TSSplitAmounts,
    TSSplitPercentages,
    TSSplitItems
} TSSplitMethod;

typedef enum
{
    TSTabStatusEditing,
    TSTabStatusActive,
    TSTabStatusSettled
} TSTabStatus;

@interface TSTab : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSNumber *totalAmount;
@property (nonatomic, strong) TSCurrency *currency;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) TSTabStatus status;
@property (nonatomic, copy) NSArray *users;
@property (nonatomic, assign) TSSplitMethod splitMethod;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSMutableArray *transactions;

@property (nonatomic, strong, readonly) NSNumber *paid;
@property (nonatomic, strong, readonly) NSNumber *remains;

@end