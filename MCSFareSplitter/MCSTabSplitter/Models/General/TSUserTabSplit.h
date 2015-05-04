//
//  TSUserTabSplit.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TSTabUser;
@class TSTab;

typedef enum
{
    TSUserTabTypeOwes,
    TSUserTabTypeOwed,
    TSUserTabTypeSettled
} TSUserTabDebtType;

typedef enum
{
    TSUserTypeParticipant,
    TSUserTypePayer
} TSUserTabType;

@interface TSUserTabSplit : NSObject

@property (nonatomic, strong) TSTabUser *user;
@property (nonatomic, strong) TSTab *tab;
@property (nonatomic, strong) NSNumber *initialAmount;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, assign, readonly) TSUserTabDebtType userDebtType;
@property (nonatomic, assign, readonly) TSUserTabType userTabType;

-(instancetype)initWithNormalUser:(TSTabUser *)user andTab:(TSTab *)tab withAmount:(NSNumber *)amount;
-(instancetype)initWithPayerUser:(TSTabUser *)user andTab:(TSTab *)tab withAmount:(NSNumber *)amount;

@end
