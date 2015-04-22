//
//  FSCurrency.h
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCurrency : NSObject

@property (nonatomic) NSString *shortName;
@property (nonatomic) NSString *fullName;

- (id)initWithShortName:(NSString *) shortName withFullName:(NSString *) fullName;

@end