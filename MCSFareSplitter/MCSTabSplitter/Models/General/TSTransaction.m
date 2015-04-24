//
//  TSTransaction.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTransaction.h"

@implementation TSTransaction

-(instancetype)initWithAmount:(NSNumber *)amount from:(TSTabUser *)sourceUser to:(TSTabUser *)destinationUser withCreationDate:(NSDate *)date
{
    if(self = [super init])
    {
        self.amount = amount;
        self.sourceUser = sourceUser;
        self.destinationUser = destinationUser;
        self.created = date;
    }
    
    return self;
}

@end