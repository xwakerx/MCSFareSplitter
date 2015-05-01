//
//  SplitterTests.m
//  MCSFareSplitter
//
//  Created by Manuel Camacho on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TSSplitController.h"
#import "TSTabUser.h"
#import "TSItem.h"
#import "TSTab.h"
#import "TSTransaction.h"
#import "TSUserTabSplit.h"

@interface SplitterTests : XCTestCase

@end

@implementation SplitterTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
/*
-(void)testMainSplitter
{
    NSArray *users = @[[[TSTabUser alloc]initWithEmail:nil withFirstName:@"A" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"B" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"C" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"D" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"E" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"F" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"G" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"H" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"I" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"J" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"K" withMiddleName:nil withLastName:nil userType:nil]];
    
    NSArray *payments = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@(-100)],
                          [[TSUserTabSplit alloc] initWithUser:users[1] andTab:nil withAmount:@(-300)],
                          [[TSUserTabSplit alloc] initWithUser:users[2] andTab:nil withAmount:@(-500)],
                          [[TSUserTabSplit alloc] initWithUser:users[3] andTab:nil withAmount:@(-100)]];

    NSArray *debts = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@99],
                       [[TSUserTabSplit alloc] initWithUser:users[1] andTab:nil withAmount:@81],
                       [[TSUserTabSplit alloc] initWithUser:users[2] andTab:nil withAmount:@60],
                       [[TSUserTabSplit alloc] initWithUser:users[3] andTab:nil withAmount:@89],
                       [[TSUserTabSplit alloc] initWithUser:users[4] andTab:nil withAmount:@60],
                       [[TSUserTabSplit alloc] initWithUser:users[5] andTab:nil withAmount:@65],
                       [[TSUserTabSplit alloc] initWithUser:users[6] andTab:nil withAmount:@100],
                       [[TSUserTabSplit alloc] initWithUser:users[7] andTab:nil withAmount:@76],
                       [[TSUserTabSplit alloc] initWithUser:users[8] andTab:nil withAmount:@160],
                       [[TSUserTabSplit alloc] initWithUser:users[9] andTab:nil withAmount:@70],
                       [[TSUserTabSplit alloc] initWithUser:users[10] andTab:nil withAmount:@140]];
    
    TSSplitController *splitController = [TSSplitController new];
    
    [splitController splitTabWithPayments:payments andDebts:debts withCompletionBlock:^(NSArray *transactions){
        XCTAssertNotNil(transactions);
        
        NSLog(@"Main: \n%@", transactions);
    }];
}

-(void)testSplitEqually
{
    NSArray *users = @[[[TSTabUser alloc]initWithEmail:nil withFirstName:@"A" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"B" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"C" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"D" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"E" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"F" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"G" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"H" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"I" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"J" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"K" withMiddleName:nil withLastName:nil userType:nil]];
    
    NSArray *payments = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@(-100)],
                          [[TSUserTabSplit alloc] initWithUser:users[1] andTab:nil withAmount:@(-300)],
                          [[TSUserTabSplit alloc] initWithUser:users[2] andTab:nil withAmount:@(-500)],
                          [[TSUserTabSplit alloc] initWithUser:users[3] andTab:nil withAmount:@(-100)]];
    
    TSSplitController *splitController = [TSSplitController new];
    
    [splitController splitTabEquallyWithPayments:payments andParticipants:users withCompletionBlock:^(NSArray *transactions){
        XCTAssertNotNil(transactions);
        
        NSLog(@"Equally: \n%@", transactions);
    }];
}

-(void)testSplitPercentages
{
    NSArray *users = @[[[TSTabUser alloc]initWithEmail:nil withFirstName:@"A" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"B" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"C" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"D" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"E" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"F" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"G" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"H" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"I" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"J" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"K" withMiddleName:nil withLastName:nil userType:nil]];
    
    NSArray *payments = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@(-100)],
                          [[TSUserTabSplit alloc] initWithUser:users[1] andTab:nil withAmount:@(-300)],
                          [[TSUserTabSplit alloc] initWithUser:users[2] andTab:nil withAmount:@(-500)],
                          [[TSUserTabSplit alloc] initWithUser:users[3] andTab:nil withAmount:@(-100)]];
    
    NSArray *percentages = @[@10, @4, @2.55, @21, @19, @12, @7, @13, @6, @4.1, @1.35];
    
    TSSplitController *splitController = [TSSplitController new];
    
    [splitController splitTabWithPayments:payments andPercentages:percentages forParticipants:users withCompletionBlock:^(NSArray *transactions){
        XCTAssertNotNil(transactions);
        
        NSLog(@"Percentage: \n%@", transactions);
    }];
    
    
}

-(void)testSplitItems
{
    NSArray *users = @[[[TSTabUser alloc]initWithEmail:nil withFirstName:@"A" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"B" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"C" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"D" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"E" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"F" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"G" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"H" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"I" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"J" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"K" withMiddleName:nil withLastName:nil userType:nil]];
    
    NSArray *payments = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@(-100)],
                          [[TSUserTabSplit alloc] initWithUser:users[1] andTab:nil withAmount:@(-300)],
                          [[TSUserTabSplit alloc] initWithUser:users[2] andTab:nil withAmount:@(-500)],
                          [[TSUserTabSplit alloc] initWithUser:users[3] andTab:nil withAmount:@(-100)]];
    
    NSArray *items = @[[[TSItem alloc]initWithCost:@200 andDetail:@"item1" forUsers:[NSMutableArray arrayWithArray:@[users[0], users[1], users[2]]]],
                       [[TSItem alloc]initWithCost:@100 andDetail:@"item2" forUsers:[NSMutableArray arrayWithArray:@[users[1], users[2], users[3]]]],
                       [[TSItem alloc]initWithCost:@50  andDetail:@"item3" forUsers:[NSMutableArray arrayWithArray:@[users[4], users[5]]]],
                       [[TSItem alloc]initWithCost:@100 andDetail:@"item4" forUsers:[NSMutableArray arrayWithArray:@[users[0]]]],
                       [[TSItem alloc]initWithCost:@60  andDetail:@"item5" forUsers:[NSMutableArray arrayWithArray:@[users[9], users[10]]]],
                       [[TSItem alloc]initWithCost:@40  andDetail:@"item6" forUsers:[NSMutableArray arrayWithArray:users]],
                       [[TSItem alloc]initWithCost:@150 andDetail:@"item7" forUsers:[NSMutableArray arrayWithArray:@[users[10]]]],
                       [[TSItem alloc]initWithCost:@220 andDetail:@"item8" forUsers:[NSMutableArray arrayWithArray:@[users[8], users[0], users[10]]]],
                       [[TSItem alloc]initWithCost:@80  andDetail:@"item9" forUsers:[NSMutableArray arrayWithArray:@[users[9]]]]];
    
    TSSplitController *splitController = [TSSplitController new];
    
    [splitController splitTabWithPayments:payments forParticipants:users withItems:items withCompletionBlock:^(NSArray *transactions){
        XCTAssertNotNil(transactions);
        
        NSLog(@"Items: \n%@", transactions);
    }];
}

-(void)testSplitItems2
{
    NSArray *users = @[[[TSTabUser alloc]initWithEmail:nil withFirstName:@"A" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"B" withMiddleName:nil withLastName:nil userType:nil],
                       [[TSTabUser alloc]initWithEmail:nil withFirstName:@"C" withMiddleName:nil withLastName:nil userType:nil]];
    
    NSArray *payments = @[[[TSUserTabSplit alloc] initWithUser:users[0] andTab:nil withAmount:@(200)]];
    
    NSArray *items = @[[[TSItem alloc]initWithCost:@90 andDetail:@"item1" forUsers:[NSMutableArray arrayWithArray:@[users[0], users[1], users[2]]]],
                       [[TSItem alloc]initWithCost:@110 andDetail:@"item2" forUsers:[NSMutableArray arrayWithArray:@[users[0], users[1], users[2]]]]];
    
    TSSplitController *splitController = [TSSplitController new];
    
    [splitController splitTabWithPayments:payments forParticipants:users withItems:items withCompletionBlock:^(NSArray *transactions){
        XCTAssertNotNil(transactions);
        
        NSLog(@"Items 2:\n%@", transactions);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/
@end
