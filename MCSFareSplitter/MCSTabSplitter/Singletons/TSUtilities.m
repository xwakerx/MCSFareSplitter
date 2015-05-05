//
//  Utilities.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/17/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSUtilities.h"

@implementation TSUtilities

+(void) showAlertInController:(UIViewController *) controller withMessage: (NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: message
                                                   delegate: controller
                                          cancelButtonTitle: NSLocalizedString(@"ok", nil)
                                          otherButtonTitles: nil];
    [alert show];
}

+(void) showAlertInController:(UIViewController *) controller withTitle:(NSString *) title withMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: controller
                                          cancelButtonTitle: NSLocalizedString(@"ok", nil)
                                          otherButtonTitles: nil];
    [alert show];
}

+ (NSString *) getDateString:(NSDate *) date{
    if(date == nil){ return @""; }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    return [dateFormat stringFromDate:date];
}

+ (NSString *) getCurrencyString:(NSNumber *) amount{
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    
    // set options.
    [currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // get formatted string
    NSString* formatted = [currencyStyle stringFromNumber:amount];
    return formatted;
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

+ (bool) isValidEmailAddress: (NSString*) mail
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@".+@.+\\.[a-z]+" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:mail options:0 range:NSMakeRange(0, [mail length])];
    if (match) {
        return true;
    }else{
        return false;
    }
}

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number
{
    return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
}

+ (NSNumber *)addValuesInArray:(NSArray *)array fromValueBlock:(NSNumber *(^)(NSInteger))valueBlock
{
    NSDecimalNumber *decimalNumber = [TSUtilities decimalNumberWithNumber:@0];
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSDecimalNumber *value = [TSUtilities decimalNumberWithNumber:valueBlock(i)];
        decimalNumber = [decimalNumber decimalNumberByAdding:value];
    }
    
    return (NSNumber *)decimalNumber;
}

@end