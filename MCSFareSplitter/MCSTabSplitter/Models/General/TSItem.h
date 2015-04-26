//
//  TSItem.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSItem : NSObject

@property (nonatomic, copy)     NSString *detail;
@property (nonatomic, strong)   NSNumber *cost;
@property (nonatomic, copy)     NSArray *enrolledUsers;

-(instancetype)initWithCost:(NSNumber *)cost andDetail:(NSString *)detail forUsers:(NSArray *)users;

@end