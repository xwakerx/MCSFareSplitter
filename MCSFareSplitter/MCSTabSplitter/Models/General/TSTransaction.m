//
//  TSTransaction.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTransaction.h"
#import "TSTabUser.h"

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

-(NSString *)description
{
    return [[super description] stringByAppendingString:[NSString stringWithFormat:@"From: %@ - To: %@ - Amount: %@",
                                                         self.sourceUser.firstName,
                                                         self.destinationUser.firstName,
                                                         self.amount]];
}

@end