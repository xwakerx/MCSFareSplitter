//
//  TSUserTabSplit.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSUserTabSplit.h"

@implementation TSUserTabSplit

-(instancetype)initWithUser:(TSTabUser *)user andTab:(TSTab *)tab withAmount:(NSNumber *)amount
{
    if(self = [super init])
    {
        self.user = user;
        self.tab = tab;
        self.amount = amount;
    }
    return self;
}

-(TSUserTabType)userType
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
