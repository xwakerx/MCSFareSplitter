//
//  TSItem.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSItem.h"

@implementation TSItem

-(instancetype)initWithCost:(NSNumber *)cost andDetail:(NSString *)detail{
    if(self = [super init])
    {
        self.cost = cost;
        self.detail = detail;
        self.enrolledUsers = [NSMutableArray new];
    }
    return self;
}

-(instancetype)initWithCost:(NSNumber *)cost andDetail:(NSString *)detail forUsers:(NSMutableArray *)users
{
    if(self = [super init])
    {
        self.cost = cost;
        self.detail = detail;
        self.enrolledUsers = users;
    }
    return self;
}

@end
