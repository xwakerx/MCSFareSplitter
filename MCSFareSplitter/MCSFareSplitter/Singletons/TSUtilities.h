//
//  Utilities.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/17/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSUtilities : NSObject

+ (NSString *) getDateString:(NSDate *) date;

+ (Boolean) charsAreValidAmount:(NSString *) amount;

+ (Boolean) isValidAmount:(NSString *) amount;

@end
