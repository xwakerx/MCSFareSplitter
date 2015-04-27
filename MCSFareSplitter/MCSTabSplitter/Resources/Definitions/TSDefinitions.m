//
//  FSDefinitions.m
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSDefinitions.h"

@implementation TSDefinitions

+ (NSArray *) currencies{
    static NSArray *currencies = nil;
    if(currencies == nil){
        currencies = @[
                       [[TSCurrency alloc] initWithShortName:@"USD" withFullName:@"United States Dollar"],
                       [[TSCurrency alloc] initWithShortName:@"MXP" withFullName:@"Mexican Peso"],
                       [[TSCurrency alloc] initWithShortName:@"IRP" withFullName:@"Indian Rupie"]
                    ];
    }
    return currencies;
}

@end
