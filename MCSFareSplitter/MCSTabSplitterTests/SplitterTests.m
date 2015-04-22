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

-(void)testMainSplitter
{
    NSArray *payments = @[@{kId: @"a",
                            kAmount: @100},
                          @{kId: @"b",
                            kAmount: @300},
                          @{kId: @"c",
                            kAmount: @500},
                          @{kId: @"d",
                            kAmount: @100}];
    
    NSMutableDictionary *a = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"a", kAmount: @99}];
    NSMutableDictionary *b = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"b", kAmount: @81}];
    NSMutableDictionary *c = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"c", kAmount: @60}];
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"d", kAmount: @89}];
    NSMutableDictionary *e = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"e", kAmount: @60}];
    NSMutableDictionary *f = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"f", kAmount: @65}];
    NSMutableDictionary *g = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"g", kAmount: @100}];
    NSMutableDictionary *h = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"h", kAmount: @76}];
    NSMutableDictionary *i = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"i", kAmount: @160}];
    NSMutableDictionary *j = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"j", kAmount: @70}];
    NSMutableDictionary *k = [NSMutableDictionary dictionaryWithDictionary:@{kId: @"k", kAmount: @140}];
    
    NSArray *debts = @[a, b, c, d, e, f, g, h, i, j, k];
    
    TSSplitController *splitController = [TSSplitController new];
    
    NSArray *transactions = [splitController splitTabWithPayments:payments andDebts:debts];
    
    XCTAssertNotNil(transactions);
    
    NSLog(@"%@", transactions);
}

-(void)testSplitEqually
{
    NSArray *payments = @[@{kId: @"a",
                            kAmount: @100},
                          @{kId: @"b",
                            kAmount: @300},
                          @{kId: @"c",
                            kAmount: @500},
                          @{kId: @"d",
                            kAmount: @100}];
    
    NSArray *participants = @[@{kId: @"a"},
                              @{kId: @"b"},
                              @{kId: @"c"},
                              @{kId: @"d"},
                              @{kId: @"e"},
                              @{kId: @"f"},
                              @{kId: @"g"},
                              @{kId: @"h"},
                              @{kId: @"i"},
                              @{kId: @"j"},
                              @{kId: @"k"}];
    
    TSSplitController *splitController = [TSSplitController new];
    
    NSArray *transactions = [splitController splitTabEquallyWithPayments:payments andParticipants:participants];
    
    XCTAssertNotNil(transactions);
    
    NSLog(@"%@", transactions);
}

-(void)testSplitPercentages
{
    NSArray *payments = @[@{kId: @"a",
                            kAmount: @100},
                          @{kId: @"b",
                            kAmount: @300},
                          @{kId: @"c",
                            kAmount: @500},
                          @{kId: @"d",
                            kAmount: @100}];
    
    NSArray *participants = @[@{kId: @"a"},
                              @{kId: @"b"},
                              @{kId: @"c"},
                              @{kId: @"d"},
                              @{kId: @"e"},
                              @{kId: @"f"},
                              @{kId: @"g"},
                              @{kId: @"h"},
                              @{kId: @"i"},
                              @{kId: @"j"},
                              @{kId: @"k"}];
    
    NSArray *percentages = @[@10, @4, @2.55, @21, @19, @12, @7, @13, @6, @4.1, @1.35];
    
    TSSplitController *splitController = [TSSplitController new];
    
    NSArray *transactions = [splitController splitTabWithPayments:payments andPercentages:percentages forParticipants:participants];
    
    XCTAssertNotNil(transactions);
    
    NSLog(@"%@", transactions);
}

-(void)testSplitItems
{
    NSArray *payments = @[@{kId: @"a",
                            kAmount: @100},
                          @{kId: @"b",
                            kAmount: @300},
                          @{kId: @"c",
                            kAmount: @500},
                          @{kId: @"d",
                            kAmount: @100}];
    
    NSArray *participants = @[@{kId: @"a"},
                              @{kId: @"b"},
                              @{kId: @"c"},
                              @{kId: @"d"},
                              @{kId: @"e"},
                              @{kId: @"f"},
                              @{kId: @"g"},
                              @{kId: @"h"},
                              @{kId: @"i"},
                              @{kId: @"j"},
                              @{kId: @"k"}];
    
    NSArray *items = @[@{kItemDescription: @"item1", kCost: @200, kParticipants: @[@{kId: @"a"}, @{kId: @"b"},@{kId: @"c"}]},
                       @{kItemDescription: @"item1", kCost: @100, kParticipants: @[@{kId: @"b"}, @{kId: @"c"},@{kId: @"d"}]},
                       @{kItemDescription: @"item1", kCost: @50, kParticipants: @[@{kId: @"e"}, @{kId: @"f"}]},
                       @{kItemDescription: @"item1", kCost: @100, kParticipants: @[@{kId: @"a"}]},
                       @{kItemDescription: @"item1", kCost: @60, kParticipants: @[@{kId: @"j"}, @{kId: @"k"}]},
                       @{kItemDescription: @"item1", kCost: @40, kParticipants: @[@{kId: @"a"}, @{kId: @"b"},@{kId: @"c"}, @{kId: @"d"}, @{kId: @"e"}, @{kId: @"f"}, @{kId: @"g"}, @{kId: @"h"}, @{kId: @"i"}, @{kId: @"j"}, @{kId: @"k"}]},
                       @{kItemDescription: @"item1", kCost: @150, kParticipants: @[@{kId: @"k"}]},
                       @{kItemDescription: @"item1", kCost: @220, kParticipants: @[@{kId: @"i"}, @{kId: @"a"},@{kId: @"k"}]},
                       @{kItemDescription: @"item1", kCost: @80, kParticipants: @[@{kId: @"j"}]}];
    
    TSSplitController *splitController = [TSSplitController new];
    
    NSArray *transactions = [splitController splitTabWithPayments:payments forParticipants:participants withItems:items];
    
    XCTAssertNotNil(transactions);
    
    NSLog(@"%@", transactions);
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
