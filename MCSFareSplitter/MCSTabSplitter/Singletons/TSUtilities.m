//
//  Utilities.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/17/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSUtilities.h"

@implementation TSUtilities

+ (NSString *) getDateString:(NSDate *) date{
    if(date == nil){ return @""; }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    return [dateFormat stringFromDate:date];
}

+ (Boolean) charsAreValidAmount:(NSString *) amount{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([0-9]|\\.|\\$|\\,)*$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:amount options:0 range:NSMakeRange(0, [amount length])];
    if (match) {
        return true;
    }else{
        return false;
    }
}

+ (Boolean) isValidAmount:(NSString *) amount{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\$|)([1-9]\\d{0,2}(\\,\\d{3})*|([1-9]\\d*))(\\.\\d{2})?$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:amount options:0 range:NSMakeRange(0, [amount length])];
    if (match) {
        return true;
    }else{
        return false;
    }
}

@end