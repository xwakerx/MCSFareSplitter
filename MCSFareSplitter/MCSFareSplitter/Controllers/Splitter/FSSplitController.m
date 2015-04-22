//
//  FSSplitterController.m
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FSSplitController.h"

@implementation FSSplitController


#pragma mark - MAIN SPLITTER ALGORITHM
#pragma mark -
-(NSArray *)transactionsForBillWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
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
    NSDecimalNumber *totalAmountDue = [self decimalNumberWithNumber:@0];
    totalAmountDue = [self totalAmountDueForDebts:theOnesOwed];
    
    //Start
    for (NSInteger thisGuyOwesIndex = 0; thisGuyOwesIndex < theOnesWhoOwe.count; thisGuyOwesIndex++)
    {
        if([[theOnesWhoOwe[thisGuyOwesIndex] objectForKey:kAmount] compare:@0.0] == NSOrderedDescending)
        {
            for (NSInteger toThisGuyIndex = 0; toThisGuyIndex < theOnesOwed.count; toThisGuyIndex++)
            {
                if([[theOnesOwed[toThisGuyIndex] objectForKey:kAmount] compare:@0.0] == NSOrderedAscending)
                {
                    NSDecimalNumber *settlement = [[theOnesWhoOwe[thisGuyOwesIndex] objectForKey:kAmount] decimalNumberByAdding:[theOnesOwed[toThisGuyIndex] objectForKey:kAmount]];
                    
                    if([settlement compare:@0.0] == NSOrderedDescending
                       || [settlement compare:@0.0] == NSOrderedSame)
                    {
                        totalAmountDue = [totalAmountDue decimalNumberBySubtracting:[self decimalNumberWithNumber:[theOnesOwed[toThisGuyIndex] objectForKey:kAmount]]];
                        
                        NSDecimalNumber *amount = [theOnesOwed[toThisGuyIndex] objectForKey:kAmount];
                        amount = [amount decimalNumberByMultiplyingBy:[self decimalNumberWithNumber:[NSNumber numberWithInt:-1]]];
                        
                        [theOnesOwed[toThisGuyIndex] setObject:@0 forKey:kAmount];
                        [theOnesWhoOwe[thisGuyOwesIndex] setObject:settlement forKey:kAmount];
                        
                        [transactions addObject:[self transactionFrom:theOnesWhoOwe[thisGuyOwesIndex] to:theOnesOwed[toThisGuyIndex] ofAmount:amount]];
                    }
                    else
                    {
                        totalAmountDue = [totalAmountDue decimalNumberByAdding:[self decimalNumberWithNumber:[theOnesWhoOwe[thisGuyOwesIndex] objectForKey:kAmount]]];
                        
                        NSDecimalNumber *amount = [theOnesWhoOwe[thisGuyOwesIndex] objectForKey:kAmount];
                        
                        [theOnesWhoOwe[thisGuyOwesIndex] setObject:@0 forKey:kAmount];
                        [theOnesOwed[toThisGuyIndex] setObject:settlement forKey:kAmount];
                        
                        [transactions addObject:[self transactionFrom:theOnesWhoOwe[thisGuyOwesIndex] to:theOnesOwed[toThisGuyIndex] ofAmount:amount]];
                        
                    }
                    break;
                }
            }
        }
        
        if(thisGuyOwesIndex == theOnesWhoOwe.count - 1
           && !([totalAmountDue compare:[self decimalNumberWithNumber:@0.001]] == NSOrderedAscending
           && [totalAmountDue compare:[self decimalNumberWithNumber:@(-0.001)]] == NSOrderedDescending))
        {
            thisGuyOwesIndex = -1;
        }
    }
    
    return transactions;
}

#pragma mark - Debts and payments adjustment and separation

-(NSArray *)adjustRealDebtsWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
{
    for (NSMutableDictionary *debt in debts)
    {
        NSDictionary *currentPayment;
        for (NSDictionary *payment in payments)
        {
            if([[payment objectForKey:kId] isEqualToString:[debt objectForKey:kId]])
            {
                currentPayment = payment;
                break;
            }
        }
        
        if(currentPayment)
        {
            NSDecimalNumber *debtAmt = [debt objectForKey:kAmount];
            NSDecimalNumber *payAmt = [currentPayment objectForKey:kAmount];
            
            NSDecimalNumber *currentDebtAmt = [debtAmt decimalNumberBySubtracting:payAmt];
            
            [debt setObject:currentDebtAmt forKey:kAmount];
        }
    }
    
    return debts;
}

-(NSDictionary *)separateDebtsArray:(NSArray *)debts
{
    NSMutableArray *theOnesOwed = [NSMutableArray array];
    NSMutableArray *theOnesWhoOwe = [NSMutableArray array];
    
    for (NSDictionary *element in debts)
    {
        if([[element objectForKey:kAmount] floatValue] <= 0)
        {
            [theOnesOwed addObject:element];
        }
        else
        {
            [theOnesWhoOwe addObject:element];
        }
    }
    
    return @{kTheOnesOwed:theOnesOwed, kTheOnesWhoOwe: theOnesWhoOwe};
    
}

-(NSArray *)changeNumberAmountsFromArrayToDecimalNumbers:(NSArray *)array
{
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSDictionary *element in array)
    {
        id amount = [element objectForKey:kAmount];
        if([amount isKindOfClass:[NSNumber class]])
        {
            NSDecimalNumber *decimalAmount = [self roundToTwoDecimals:[self decimalNumberWithNumber:(NSNumber *)amount]];
            NSMutableDictionary *mutableElement = [element mutableCopy];
            [mutableElement setObject:decimalAmount forKey:kAmount];
            [newArray addObject:mutableElement];
        }
    }
    
    return  [newArray copy];
}

-(NSArray *)debtsForParticipants:(NSArray *)billParticipants withItems:(NSArray *)items
{
    for (NSDictionary *item in items)
    {
        NSDecimalNumber *itemCost = [self decimalNumberWithNumber:[item objectForKey:kCost]];
        
        NSArray *itemParticipants = [item objectForKey:kParticipants];
        
        NSDecimalNumber *itemCostRealAccum = [self decimalNumberWithNumber:@0];
        
        if(!itemParticipants != itemParticipants.count == 0)
        {
            [NSException raise:@"FSSplitInvalidItemsListException" format:@"All items must have at least one participant"];
        }
        
        NSMutableDictionary *lastParticipantForItem = nil;
        
        for (NSDictionary *itemParticipant in itemParticipants)
        {
            for (NSMutableDictionary *billParticipant in billParticipants)
            {
                if([[billParticipant objectForKey:kId] isEqualToString:[itemParticipant objectForKey:kId]])
                {
                    lastParticipantForItem = billParticipant;
                    
                    NSDecimalNumber *itemParticipantsCount = [self decimalNumberWithNumber:[NSNumber numberWithInteger:itemParticipants.count]];
                    NSDecimalNumber *amount = [self roundToTwoDecimals:[itemCost decimalNumberByDividingBy:itemParticipantsCount]];
                    
                    itemCostRealAccum = [itemCostRealAccum decimalNumberByAdding:amount];
                    
                    if(![billParticipant objectForKey:kAmount])
                    {
                        [billParticipant setObject:[self decimalNumberWithNumber:@0] forKey:kAmount];
                    }
                    NSDecimalNumber *accumParticipantAmount = [[billParticipant objectForKey:kAmount] decimalNumberByAdding:amount];
                    
                    [billParticipant setObject:accumParticipantAmount forKey:kAmount];
                    
                    break;
                }
            }
        }
        if(!lastParticipantForItem)
        {
            [NSException raise:@"FSSplitInvalidItemsListException" format:@"The items list contains a user who is not in the bill"];
        }
        
        if([itemCost compare:itemCostRealAccum] != NSOrderedSame)
        {
            NSDecimalNumber *lastParticipantAmount = [lastParticipantForItem objectForKey:kAmount];
            NSDecimalNumber *remainingAmount = [itemCost decimalNumberBySubtracting:itemCostRealAccum];
            [lastParticipantForItem setObject:[lastParticipantAmount decimalNumberByAdding:remainingAmount] forKey:kAmount];
        }
        
    }
    
    return billParticipants;
}


#pragma mark - Array sorting
-(NSArray *)sortExpenseArray:(NSArray *)expenseArray withOrder:(NSComparisonResult)order
{
    switch (order) {
        case NSOrderedAscending:
            expenseArray = [expenseArray sortedArrayUsingComparator:^(NSDictionary *a, NSDictionary *b) {
                if(([[a objectForKey:kAmount] floatValue] < [[b objectForKey:kAmount] floatValue]))
                {
                    return NSOrderedAscending;
                }
                return NSOrderedDescending;
            }];
            break;
        case NSOrderedDescending:
            expenseArray = [expenseArray sortedArrayUsingComparator:^(NSDictionary *a, NSDictionary *b) {
                if(([[a objectForKey:kAmount] floatValue] > [[b objectForKey:kAmount] floatValue]))
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
    NSDecimalNumber *totalAmountDue = [self decimalNumberWithNumber:@0];
    
    for (NSMutableDictionary *debt in debts)
    {
        NSDecimalNumber *owedAmount = [NSDecimalNumber decimalNumberWithDecimal:[[debt objectForKey:kAmount] decimalValue]];
        totalAmountDue = [totalAmountDue decimalNumberByAdding:owedAmount];
    }
    
    return totalAmountDue;
}

#pragma mark - Transactions

-(NSDictionary *)transactionFrom:(NSDictionary *)payer to:(NSDictionary *)payee ofAmount:(NSDecimalNumber *)amount
{
    return @{kFrom: [payer objectForKey:kId],
             kTo: [payee objectForKey:kId],
             kAmount:amount};
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
    
    return [num decimalNumberByAdding:[self decimalNumberWithNumber:[NSNumber numberWithInt:0]] withBehavior:roundUp];
}

-(NSDecimalNumber *)decimalNumberWithNumber:(NSNumber *)number
{
    return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
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
-(NSArray *)splitBillEquallyWithPayments:(NSArray *)payments andParticipants:(NSArray *)participants
{
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    
    NSDecimalNumber *individualDebtAmount = [paymentsTotalAmount decimalNumberByDividingBy:[self decimalNumberWithNumber:[NSNumber numberWithInteger:participants.count]]];
    individualDebtAmount = [self roundToTwoDecimals:individualDebtAmount];
    NSDecimalNumber *paymentsRealAmountAccum = [self decimalNumberWithNumber:@0];
    
    NSMutableArray *debts = [NSMutableArray array];
    
    for (NSDictionary *participant in participants)
    {
        NSMutableDictionary *debt = [NSMutableDictionary dictionaryWithDictionary:@{kId: [participant objectForKey:kId], kAmount:individualDebtAmount}];
        [debts addObject:debt];
        paymentsRealAmountAccum = [paymentsRealAmountAccum decimalNumberByAdding:individualDebtAmount];
    }
    
    if(![paymentsTotalAmount isEqualToNumber:paymentsRealAmountAccum])
    {
        NSDecimalNumber *lastAmount = [[debts lastObject] objectForKey:kAmount];
        
        lastAmount = [[self decimalNumberWithNumber:lastAmount] decimalNumberByAdding:[paymentsTotalAmount decimalNumberBySubtracting:paymentsRealAmountAccum]];
        
        [[debts lastObject] setObject:lastAmount forKey:kAmount];
    }
    
    return [self splitBillWithPayments:payments andDebts:debts];
}

#pragma mark Split With Payments and Debts
-(NSArray *)splitBillWithPayments:(NSArray *)payments andDebts:(NSArray *)debts
{
    payments = [self changeNumberAmountsFromArrayToDecimalNumbers:payments];
    debts = [self changeNumberAmountsFromArrayToDecimalNumbers:debts];
    
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    NSDecimalNumber *debtsTotalAmount = [self totalAmountDueForDebts:debts];
    
    if(![paymentsTotalAmount isEqualToNumber:debtsTotalAmount])
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The amounts of payments and debts don't match"];
    }
    return [self transactionsForBillWithPayments:payments andDebts:debts];
}

#pragma mark Split with payments and percentages
-(NSArray *)splitBillWithPayments:(NSArray *)payments andPercentages:(NSArray *)percentages forParticipants:(NSArray *)participants
{
    if(percentages.count != participants.count)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The count of percentages does not match the coung ot participants"];
    }
    
    NSDecimalNumber *totalPercentage = [self decimalNumberWithNumber:@0];
    
    for (NSNumber *number in percentages)
    {
        totalPercentage = [totalPercentage decimalNumberByAdding:[self decimalNumberWithNumber:number]];
    }
    
    if([totalPercentage compare:[self decimalNumberWithNumber:@100]] != NSOrderedSame)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The percentages do not sum 100"];
    }
    
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    NSDecimalNumber *paymentsRealAmountAccum = [self decimalNumberWithNumber:@0];
    
    NSMutableArray *debts = [NSMutableArray array];
    
    for (NSInteger i = 0; i < participants.count; i++)
    {
        NSString *participantID = [participants[i] objectForKey:kId];
        
        NSDecimalNumber *percentage = [self decimalNumberWithNumber:percentages[i]];
        percentage = [percentage decimalNumberByDividingBy:[self decimalNumberWithNumber:@100]];
        
        NSDecimalNumber *amount = [paymentsTotalAmount decimalNumberByMultiplyingBy:percentage];
        
        NSMutableDictionary *debt = [NSMutableDictionary dictionaryWithDictionary:@{kId:participantID, kAmount:amount}];
        [debts addObject:debt];
        
        paymentsRealAmountAccum = [paymentsRealAmountAccum decimalNumberByAdding:amount];
    }
    
    if(![paymentsTotalAmount isEqualToNumber:paymentsRealAmountAccum])
    {
        NSDecimalNumber *lastAmount = [[debts lastObject] objectForKey:kAmount];
        
        lastAmount = [[self decimalNumberWithNumber:lastAmount] decimalNumberByAdding:[paymentsTotalAmount decimalNumberBySubtracting:paymentsRealAmountAccum]];
        
        [[debts lastObject] setObject:lastAmount forKey:kAmount];
    }
    
    return [self splitBillWithPayments:payments andDebts:debts];
}

#pragma mark Split with items list

-(NSArray *)splitBillWithPayments:(NSArray *)payments forParticipants:(NSArray *)participants withItems:(NSArray *)items
{
    NSDecimalNumber *paymentsTotalAmount = [self totalAmountDueForDebts:payments];
    NSDecimalNumber *itemsTotalCost = [self decimalNumberWithNumber:@0];
    
    for (NSDictionary *item in items)
    {
        NSDecimalNumber *itemCost = [self decimalNumberWithNumber:[item objectForKey:kCost]];
        
        itemsTotalCost = [itemsTotalCost decimalNumberByAdding:itemCost];
    }
    
    if([paymentsTotalAmount compare:itemsTotalCost] != NSOrderedSame)
    {
        [NSException raise:@"FSSplitInvalidArgumentsException" format:@"The total cost of items does not match the payments total amount"];
    }
    
    participants = [self arrayOfDictionariesToArrayOfMutableDictionaries:participants];
    
    NSArray *debts = [self debtsForParticipants:participants withItems:items];
    
    return [self splitBillWithPayments:payments andDebts:debts];
}

@end