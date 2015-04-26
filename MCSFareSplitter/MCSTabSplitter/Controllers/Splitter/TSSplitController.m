//
//  FSSplitterController.m
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSSplitController.h"
#import "TSUtilities.h"
#import "TSTabUser.h"
#import "TSItem.h"
#import "TSTab.h"
#import "TSTransaction.h"
#import "TSUserTabSplit.h"

@implementation TSSplitController

-(instancetype)initWithTab:(TSTab *)tab
{
    if(self = [super init])
    {
        self.tab = tab;
    }
    return self;
}


#pragma mark - MAIN SPLITTER ALGORITHM
#pragma mark -
-(NSArray *)transactionsForTabWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
{
    //Calculate real debt
    debts = [self adjustRealDebtsWithPayments:payments andDebts:debts];
    
    //Sort debt array
    debts = [self sortExpenseArray:debts withOrder:NSOrderedAscending];
    
    //Separate debt (owe and owed)
    NSDictionary *separatedDebts = [self separateDebtsArray:debts];
    
    NSMutableArray *theOnesOwed = [separatedDebts objectForKey:kTheOnesOwed];
    NSMutableArray *theOnesWhoOwe = [separatedDebts objectForKey:kTheOnesWhoOwe];
    NSMutableArray *transactions = [NSMutableArray array];
    
    theOnesOwed = [[self sortExpenseArray:[theOnesOwed copy] withOrder:NSOrderedDescending] mutableCopy];
    
    //Total amount due
    NSDecimalNumber *totalAmountDue = [TSUtilities decimalNumberWithNumber:@0];
    totalAmountDue = [self totalAmountDueForDebts:theOnesOwed];
    
    //Start
    for (NSInteger thisGuyOwesIndex = 0; thisGuyOwesIndex < theOnesWhoOwe.count; thisGuyOwesIndex++)
    {
        TSUserTabSplit *thisGuyOwes = (TSUserTabSplit *)theOnesWhoOwe[thisGuyOwesIndex];
        
        if([thisGuyOwes.amount compare:@0.0] == NSOrderedDescending)
        {
            for (NSInteger toThisGuyIndex = 0; toThisGuyIndex < theOnesOwed.count; toThisGuyIndex++)
            {
                TSUserTabSplit *toThisGuy = (TSUserTabSplit *)theOnesOwed[toThisGuyIndex];
                
                if([toThisGuy.amount compare:@0.0] == NSOrderedAscending)
                {
                    NSDecimalNumber *thisGuyOwesAmount = [TSUtilities decimalNumberWithNumber:thisGuyOwes.amount];
                    NSDecimalNumber *toThisGuyAmount = [TSUtilities decimalNumberWithNumber:toThisGuy.amount];
                    
                    NSDecimalNumber *settlement = [thisGuyOwesAmount decimalNumberByAdding:toThisGuyAmount];
                    
                    if([settlement compare:@0.0] == NSOrderedDescending
                       || [settlement compare:@0.0] == NSOrderedSame)
                    {
                        totalAmountDue = [totalAmountDue decimalNumberBySubtracting:[TSUtilities decimalNumberWithNumber:toThisGuyAmount]];
                        
                        NSDecimalNumber *amount = toThisGuyAmount;
                        amount = [amount decimalNumberByMultiplyingBy:[TSUtilities decimalNumberWithNumber:[NSNumber numberWithInt:-1]]];
                        
                        thisGuyOwes.amount = settlement;
                        toThisGuy.amount = @0;
                        
                        [transactions addObject:[self transactionFrom:thisGuyOwes to:toThisGuy ofAmount:amount]];
                    }
                    else
                    {
                        totalAmountDue = [totalAmountDue decimalNumberByAdding:[TSUtilities decimalNumberWithNumber:thisGuyOwesAmount]];
                        
                        NSDecimalNumber *amount = thisGuyOwesAmount;
                        
                        thisGuyOwes.amount = @0;
                        toThisGuy.amount = settlement;
                        
                        [transactions addObject:[self transactionFrom:thisGuyOwes to:toThisGuy ofAmount:amount]];
                    }
                    break;
                }
            }
        }
        
        if(thisGuyOwesIndex == theOnesWhoOwe.count - 1
           && !([totalAmountDue compare:[TSUtilities decimalNumberWithNumber:@0.001]] == NSOrderedAscending
           && [totalAmountDue compare:[TSUtilities decimalNumberWithNumber:@(-0.001)]] == NSOrderedDescending))
        {
            thisGuyOwesIndex = -1;
        }
    }
    
    return transactions;
}

#pragma mark - Debts and payments adjustment and separation

-(NSArray *)adjustRealDebtsWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
{
    for (TSUserTabSplit *debt in debts)
    {
        TSUserTabSplit *currentPayment;
        for (TSUserTabSplit *payment in payments)
        {
            if(payment.user == debt.user)
            {
                currentPayment = payment;
                break;
            }
        }
        
        if(currentPayment)
        {
            NSDecimalNumber *debtAmt = [TSUtilities decimalNumberWithNumber:debt.amount];
            NSDecimalNumber *payAmt = [TSUtilities decimalNumberWithNumber:currentPayment.amount];
            
            NSDecimalNumber *currentDebtAmt = [debtAmt decimalNumberBySubtracting:payAmt];
            
            debt.amount = (NSNumber *)currentDebtAmt;
        }
    }
    
    return debts;
}

-(NSDictionary *)separateDebtsArray:(NSArray *)debts
{
    NSMutableArray *theOnesOwed = [NSMutableArray array];
    NSMutableArray *theOnesWhoOwe = [NSMutableArray array];
    
    for (TSUserTabSplit *debt in debts)
    {
        if([debt.amount floatValue] <= 0)
        {
            [theOnesOwed addObject:debt];
        }
        else
        {
            [theOnesWhoOwe addObject:debt];
        }
    }
    
    return @{kTheOnesOwed:theOnesOwed, kTheOnesWhoOwe: theOnesWhoOwe};
    
}

-(NSArray *)paymentsToPositives:(NSArray *)payments
{
    NSMutableArray *mutablePayments = [NSMutableArray array];
    
    for (TSUserTabSplit *payment in payments)
    {
        TSUserTabSplit *newPayment = [[TSUserTabSplit alloc]initWithUser:payment.user andTab:payment.tab withAmount:payment.amount];
        
        if(payment.amount.doubleValue < 0)
        {
            NSDecimalNumber *decimalAmount = [TSUtilities decimalNumberWithNumber:newPayment.amount];
            decimalAmount = [decimalAmount decimalNumberByMultiplyingBy:[TSUtilities decimalNumberWithNumber:@(-1)]];
            
            newPayment.amount = (NSNumber *)decimalAmount;
        }
        
        [mutablePayments addObject:newPayment];
    }
    
    return [mutablePayments copy];
}

-(NSArray *)debtsForParticipants:(NSArray *)tabParticipants withItems:(NSArray *)items
{
    NSMutableArray *userTabSplitsArray = [NSMutableArray array];
    
    for (TSTabUser *user in tabParticipants)
    {
        TSUserTabSplit *userTabSplit = [[TSUserTabSplit alloc]initWithUser:user andTab:nil withAmount:@0];
        [userTabSplitsArray addObject:userTabSplit];
    }
    
    for (TSItem *item in items)
    {
        NSDecimalNumber *itemCost = [TSUtilities decimalNumberWithNumber:item.cost];
        
        NSArray *itemParticipants = item.enrolledUsers;
        
        NSDecimalNumber *itemCostRealAccum = [TSUtilities decimalNumberWithNumber:@0];
        
        if(!itemParticipants != itemParticipants.count == 0)
        {
            [NSException raise:@"FSSplitInvalidItemsListException" format:@"All items must have at least one participant"];
        }
        
        TSUserTabSplit *lastParticipantForItem = nil;

        for (TSTabUser *itemParticipant in itemParticipants)
        {
            for (TSUserTabSplit *tabParticipant in userTabSplitsArray)
            {
                if(tabParticipant.user == itemParticipant)
                {
                    lastParticipantForItem = tabParticipant;
                    
                    NSDecimalNumber *itemParticipantsCount = [TSUtilities decimalNumberWithNumber:[NSNumber numberWithInteger:itemParticipants.count]];
                    NSDecimalNumber *amount = [self roundToTwoDecimals:[itemCost decimalNumberByDividingBy:itemParticipantsCount]];
                    
                    itemCostRealAccum = [itemCostRealAccum decimalNumberByAdding:amount];

                    NSDecimalNumber *accumParticipantAmount = [[TSUtilities decimalNumberWithNumber:tabParticipant.amount] decimalNumberByAdding:amount];
                    
                    tabParticipant.amount = (NSNumber *)accumParticipantAmount;
                    
                    break;
                }
            }
        }
        if(!lastParticipantForItem)
        {
            [NSException raise:@"FSSplitInvalidItemsListException" format:@"The items list contains a user who is not in the tab"];
        }
        
        if([itemCost compare:itemCostRealAccum] != NSOrderedSame)
        {
            NSDecimalNumber *lastParticipantAmount = [TSUtilities decimalNumberWithNumber:lastParticipantForItem.amount];
            NSDecimalNumber *remainingAmount = [itemCost decimalNumberBySubtracting:itemCostRealAccum];
            lastParticipantForItem.amount = (NSNumber *)[lastParticipantAmount decimalNumberByAdding:remainingAmount];
        }
    }
    
    return [userTabSplitsArray copy];
}


#pragma mark - Array sorting
-(NSArray *)sortExpenseArray:(NSArray *)expenseArray withOrder:(NSComparisonResult)order
{
    switch (order) {
        case NSOrderedAscending:
            expenseArray = [expenseArray sortedArrayUsingComparator:^(TSUserTabSplit *a, TSUserTabSplit *b) {
                if(([a.amount floatValue] < [b.amount floatValue]))
                {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;
            }];
            break;
        case NSOrderedDescending:
            expenseArray = [expenseArray sortedArrayUsingComparator:^(TSUserTabSplit *a, TSUserTabSplit *b) {
                if(([a.amount floatValue] > [b.amount floatValue]))
                {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;
            }];
            break;
        default:
            break;
    }
    
    return expenseArray;
}

#pragma mark - Total Amount
-(NSDecimalNumber *)totalAmountDueForDebts:(NSArray *)debts
{
    NSDecimalNumber *totalAmountDue = [TSUtilities decimalNumberWithNumber:@0];
    
    for (TSUserTabSplit *debt in debts)
    {
        NSDecimalNumber *owedAmount = [NSDecimalNumber decimalNumberWithDecimal:[debt.amount decimalValue]];
        totalAmountDue = [totalAmountDue decimalNumberByAdding:owedAmount];
    }
    
    return totalAmountDue;
}

#pragma mark - Transactions

-(TSTransaction *)transactionFrom:(TSUserTabSplit *)payer to:(TSUserTabSplit *)payee ofAmount:(NSDecimalNumber *)amount
{
    return [[TSTransaction alloc]initWithAmount:amount from:payer.user to:payee.user withCreationDate:nil];
}

#pragma mark - Rounding

-(NSDecimalNumber *)roundToTwoDecimals:(NSDecimalNumber *) num
{
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundUp
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    
    return [num decimalNumberByAdding:[TSUtilities decimalNumberWithNumber:[NSNumber numberWithInt:0]] withBehavior:roundUp];
}

#pragma mark - Utility methods

-(NSArray *)arrayOfDictionariesToArrayOfMutableDictionaries:(NSArray *)array
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array)
    {
        NSMutableDictionary *mutableDictionary = [dictionary mutableCopy];
        [mutableArray addObject:mutableDictionary];
    }
    return [mutableArray copy];
}

#pragma mark - PUBLIC METHODS
#pragma mark -

#pragma mark Split Equally
-(NSArray *)splitTabEquallyWithPayments:(NSArray *)payments andParticipants:(NSArray *)participants
{
    payments = [self paymentsToPositives:payments];
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    
    NSDecimalNumber *individualDebtAmount = [paymentsTotalAmount decimalNumberByDividingBy:[TSUtilities decimalNumberWithNumber:[NSNumber numberWithInteger:participants.count]]];
    individualDebtAmount = [self roundToTwoDecimals:individualDebtAmount];
    NSDecimalNumber *paymentsRealAmountAccum = [TSUtilities decimalNumberWithNumber:@0];
    
    NSMutableArray *debts = [NSMutableArray array];
    
    for (TSTabUser *participant in participants)
    {
        TSUserTabSplit *debt = [[TSUserTabSplit alloc]initWithUser:participant andTab:nil withAmount:individualDebtAmount];
        [debts addObject:debt];
        paymentsRealAmountAccum = [paymentsRealAmountAccum decimalNumberByAdding:individualDebtAmount];
    }
    
    if(![paymentsTotalAmount isEqualToNumber:paymentsRealAmountAccum])
    {
        NSDecimalNumber *lastAmount = [TSUtilities decimalNumberWithNumber:((TSUserTabSplit *)[debts lastObject]).amount];
        
        lastAmount = [[TSUtilities decimalNumberWithNumber:lastAmount] decimalNumberByAdding:[paymentsTotalAmount decimalNumberBySubtracting:paymentsRealAmountAccum]];
        
        ((TSUserTabSplit *)[debts lastObject]).amount = (NSNumber *)lastAmount;
    }
    
    return [self splitTabWithPayments:payments andDebts:debts];
}

#pragma mark Split With Payments and Debts
-(NSArray *)splitTabWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
{
    payments = [self paymentsToPositives:payments];
    
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    NSDecimalNumber *debtsTotalAmount = [self totalAmountDueForDebts:debts];
    
    if(![paymentsTotalAmount isEqualToNumber:debtsTotalAmount])
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The amounts of payments and debts don't match"];
    }
    return [self transactionsForTabWithPayments:payments andDebts:debts];
}

#pragma mark Split with payments and percentages
-(NSArray *)splitTabWithPayments:(NSArray *)payments andPercentages:(NSArray *)percentages forParticipants:(NSArray *)participants
{
    if(percentages.count != participants.count)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The count of percentages does not match the coung ot participants"];
    }
    
    NSDecimalNumber *totalPercentage = [TSUtilities decimalNumberWithNumber:@0];
    
    for (NSNumber *number in percentages)
    {
        totalPercentage = [totalPercentage decimalNumberByAdding:[TSUtilities decimalNumberWithNumber:number]];
    }
    
    if([totalPercentage compare:[TSUtilities decimalNumberWithNumber:@100]] != NSOrderedSame)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The percentages do not sum 100"];
    }
    
    payments = [self paymentsToPositives:payments];
    
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    NSDecimalNumber *paymentsRealAmountAccum = [TSUtilities decimalNumberWithNumber:@0];
    
    NSMutableArray *debts = [NSMutableArray array];
    
    for (NSInteger i = 0; i < participants.count; i++)
    {
        NSDecimalNumber *percentage = [TSUtilities decimalNumberWithNumber:percentages[i]];
        percentage = [percentage decimalNumberByDividingBy:[TSUtilities decimalNumberWithNumber:@100]];
        
        NSDecimalNumber *amount = [paymentsTotalAmount decimalNumberByMultiplyingBy:percentage];
        
        TSUserTabSplit *debt = [[TSUserTabSplit alloc]initWithUser:participants[i] andTab:nil withAmount:amount];
        [debts addObject:debt];
        
        paymentsRealAmountAccum = [paymentsRealAmountAccum decimalNumberByAdding:amount];
    }
    
    if(![paymentsTotalAmount isEqualToNumber:paymentsRealAmountAccum])
    {
        NSDecimalNumber *lastAmount = [TSUtilities decimalNumberWithNumber:((TSUserTabSplit *)[debts lastObject]).amount];
        
        lastAmount = [[TSUtilities decimalNumberWithNumber:lastAmount] decimalNumberByAdding:[paymentsTotalAmount decimalNumberBySubtracting:paymentsRealAmountAccum]];
        
        ((TSUserTabSplit *)[debts lastObject]).amount = (NSNumber *)lastAmount;
    }
    
    return [self splitTabWithPayments:payments andDebts:debts];
}

#pragma mark Split with items list

-(NSArray *)splitTabWithPayments:(NSArray *)payments forParticipants:(NSArray *)participants withItems:(NSArray *)items
{
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:[self paymentsToPositives:payments]];
    NSDecimalNumber *itemsTotalCost = [TSUtilities decimalNumberWithNumber:@0];
    
    for (TSItem *item in items)
    {
        NSDecimalNumber *itemCost = [TSUtilities decimalNumberWithNumber:item.cost];
        
        itemsTotalCost = [itemsTotalCost decimalNumberByAdding:itemCost];
    }
    
    if([paymentsTotalAmount compare:itemsTotalCost] != NSOrderedSame)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The total cost of items does not match the payments total amount"];
    }
    
    NSArray *debts = [self debtsForParticipants:participants withItems:items];
    
    return [self splitTabWithPayments:payments andDebts:debts];
}

@end