//
//  Utilities.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/17/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TSUtilities : NSObject

+(void) showAlertInController:(UIViewController *) controller withMessage: (NSString *) message;
+(void) showAlertInController:(UIViewController *) controller withTitle:(NSString *) title withMessage:(NSString *) message;

+ (NSString *) getDateString:(NSDate *) date;

+ (Boolean) charsAreValidAmount:(NSString *) amount;

+ (Boolean) isValidAmount:(NSString *) amount;
+ (bool) isValidEmailAddress: (NSString*) mail;

+ (NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number;

+ (NSNumber *)addValuesInArray:(NSArray *)array fromValueBlock:(NSNumber *(^)(NSInteger))valueBlock;

@end