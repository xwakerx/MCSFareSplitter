//
//  FSSplitterController.h
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kAmount = @"amount";
static NSString *const kId = @"id";
static NSString *const kTheOnesOwed = @"theOnesOwed";
static NSString *const kTheOnesWhoOwe = @"theOnesWhoOwe";
static NSString *const kFrom = @"from";
static NSString *const kTo = @"to";
static NSString *const kCost = @"cost";
static NSString *const kParticipants = @"participants";
static NSString *const kItemDescription = @"itemDescription";

@interface FSSplitController : NSObject

-(NSArray *)splitBillWithPayments:(NSArray *)payments andDebts:(NSArray *)debts;
-(NSArray *)splitBillEquallyWithPayments:(NSArray *)payments andParticipants:(NSArray *)participants;
-(NSArray *)splitBillWithPayments:(NSArray *)payments andPercentages:(NSArray *)percentages forParticipants:(NSArray *)participants;
-(NSArray *)splitBillWithPayments:(NSArray *)payments forParticipants:(NSArray *)participants withItems:(NSArray *)items;

@end
