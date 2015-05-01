//
//  CoreDataManagerTests.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TSCoreDataManager.h"

@interface CoreDataManagerTests : XCTestCase

@end

@implementation CoreDataManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testFetch
{
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSUser" where:@[@"firstName"] isEqualTo:@[@"manuel"]];
    XCTAssertNotNil(users);
}

@end
