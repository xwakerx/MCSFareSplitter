//
//  TSItem.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSItem : NSObject

@property (nonatomic, assign)   NSInteger *itemId;

@property (nonatomic, copy)     NSString *detail;
@property (nonatomic, strong)   NSNumber *cost;
@property (nonatomic, copy)     NSMutableArray *enrolledUsers;

-(instancetype)initWithCost:(NSNumber *)cost andDetail:(NSString *)detail;
-(instancetype)initWithCost:(NSNumber *)cost andDetail:(NSString *)detail forUsers:(NSMutableArray *)users;

@end