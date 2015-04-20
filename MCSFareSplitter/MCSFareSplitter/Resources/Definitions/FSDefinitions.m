//
//  FSDefinitions.m
//  MCSFareSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FSDefinitions.h"

@implementation FSDefinitions

+ (NSArray *) currencies{
    static NSArray *currencies = nil;
    if(currencies == nil){
        currencies = @[
                       [[FSCurrency alloc] initWithShortName:@"USD" withFullName:@"United States Dollar"],
                       [[FSCurrency alloc] initWithShortName:@"MXN" withFullName:@"Mexican Peso"],
                       [[FSCurrency alloc] initWithShortName:@"IRP" withFullName:@"Indian Rupie"]
                    ];
    }
    return currencies;
}

@end
