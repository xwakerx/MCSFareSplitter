//
//  FSCurrency.m
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSCurrency.h"

@implementation TSCurrency

- (id)init{
    self = [super init];
    if(self){
        self.shortName = @"";
        self.fullName = @"";
    }
    return self;
}

- (id)initWithShortName:(NSString *) shortName withFullName:(NSString *) fullName{
    self = [super init];
    if(self){
        self.shortName = shortName;
        self.fullName = fullName;
    }
    return self;
}

@end
