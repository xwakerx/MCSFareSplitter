//
//  TSTab.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTab.h"
#import "TSTabUser.h"
#import "TSUtilities.h"
#import "TSTransaction.h"

@implementation TSTab

-(NSNumber *)paid
{
    NSDecimalNumber *decimalTotalAmount = [TSUtilities decimalNumberWithNumber:self.totalAmount];
    
    NSDecimalNumber *transactionsTotalAmount = [TSUtilities decimalNumberWithNumber:[TSUtilities addValuesInArray:self.transactions fromValueBlock:^(NSInteger index){
        return ((TSTransaction *)[self.transactions objectAtIndex:index]).amount;
    }]];
    
    return (NSNumber *)[decimalTotalAmount decimalNumberByAdding:transactionsTotalAmount];
}

-(NSNumber *)remains
{
    NSDecimalNumber *paid = [TSUtilities decimalNumberWithNumber:[self paid]];
    
    NSDecimalNumber *decimalTotalAmount = [TSUtilities decimalNumberWithNumber:self.totalAmount];
    
    return  (NSNumber *)[decimalTotalAmount decimalNumberBySubtracting:paid];
}

@end