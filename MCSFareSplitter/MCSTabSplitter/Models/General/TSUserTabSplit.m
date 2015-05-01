//
//  TSUserTabSplit.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSUserTabSplit.h"

@implementation TSUserTabSplit

-(instancetype)initWithNormalUser:(TSTabUser *)user andTab:(TSTab *)tab withAmount:(NSNumber *)amount
{
    if(self = [super init])
    {
        [self initWithUser:user ofType:TSUserTypeParticipant forTab:tab withAmount:amount];
    }
    return self;
}

-(instancetype)initWithPayerUser:(TSTabUser *)user andTab:(TSTab *)tab withAmount:(NSNumber *)amount {
    if(self = [super init])
    {
        [self initWithUser:user ofType:TSUserTypePayer forTab:tab withAmount:amount];
    }
    return self;
}

-(void)initWithUser:(TSTabUser *)user ofType:(TSUserTabType)type forTab:(TSTab *)tab withAmount:(NSNumber *)amount
{
    self.user = user;
    self.tab = tab;
    self.amount = amount;
    _userTabType = type;
}

-(TSUserTabDebtType)userDebtType
{
    if([self.amount doubleValue] > 0)
    {
        return TSUserTabTypeOwes;
    }
    else if([self.amount doubleValue] < 0)
    {
        return TSUserTabTypeOwed;
    }
    else
    {
        return TSUserTabTypeSettled;
    }
}

@end
