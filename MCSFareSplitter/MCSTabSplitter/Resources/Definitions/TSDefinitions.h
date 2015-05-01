//
//  FSDefinitions.h
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSCurrency.h"

static NSString *const kTSSingletonException = @"TSSingletonException";

@interface TSDefinitions : NSObject

+ (NSArray *) currencies;

@end
