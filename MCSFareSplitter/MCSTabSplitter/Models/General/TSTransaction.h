//
//  TSTransaction.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSTabUser;

@interface TSTransaction : NSObject

@property (nonatomic, strong) TSTabUser *sourceUser;
@property (nonatomic, strong) TSTabUser *destinationUser;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSDate *created;

@end