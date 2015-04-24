//
//  TSAccount.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TSAccountTypePayable,
    TSAccountTypePayment
} TSAccountType;

@interface TSAccount : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) TSAccountType type;
@property (nonatomic, copy) NSString *email;

@end