//
//  FSSplitterController.h
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSTab;

static NSString *const kTheOnesOwed = @"theOnesOwed";
static NSString *const kTheOnesWhoOwe = @"theOnesWhoOwe";

@interface TSSplitController : NSObject

@property (nonatomic, strong) TSTab *tab;

-(instancetype)initWithTab:(TSTab *)tab;

-(void)splitTabWithPayments:(NSArray *)payments andDebts:(NSArray *)debts withCompletionBlock:(void (^)(NSArray *))completion;
-(void)splitTabEquallyWithPayments:(NSArray *)payments andParticipants:(NSArray *)participants withCompletionBlock:(void (^)(NSArray *))completion;
-(void)splitTabWithPayments:(NSArray *)payments andPercentages:(NSArray *)percentages forParticipants:(NSArray *)participants withCompletionBlock:(void (^)(NSArray *))completion;
-(void)splitTabWithPayments:(NSArray *)payments forParticipants:(NSArray *)participants withItems:(NSArray *)items withCompletionBlock:(void (^)(NSArray *))completion;

@end
