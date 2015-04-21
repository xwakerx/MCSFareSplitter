//
//  Utilities.m
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/17/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FSUtilities.h"

@implementation FSUtilities

+ (NSString *) getDateString:(NSDate *) date{
    if(date == nil){ return @""; }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    return [dateFormat stringFromDate:date];
}

@end