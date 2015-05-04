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
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSUser" where:@[@"userType"] isEqualTo:@[@0]];
    XCTAssertNotNil(users);
    
    NSLog(@"**************");
    NSLog(@"Fetch returned %li users:", (long)users.count);
    for (NSManagedObject *user in users)
    {
        [self printUser:user];
    }
    NSLog(@"**************");
   
}

-(void)testOrderedFetch
{
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSUser" where:@[@"userType"] isEqualTo:@[@0] sortedByAttribute:@"lastName"];
    XCTAssertNotNil(users);
    
    NSLog(@"**************");
    NSLog(@"Fetch returned %li users:", (long)users.count);
    for (NSManagedObject *user in users)
    {
        [self printUser:user];
    }
    NSLog(@"**************");
}


-(void)testInsert
{
    [[TSCoreDataManager sharedManager] insertObjectWithEntity:@"TSUser"
                                           withInsertionBlock:^(NSManagedObject *managedObject){
        
        XCTAssertNotNil(managedObject);
        
        [managedObject setValue:@"Sergio" forKey:@"firstName"];
        [managedObject setValue:@"Cerezo" forKey:@"lastName"];
        [managedObject setValue:@"wakex" forKey:@"username"];
        [managedObject setValue:@"sergio_wake@gmail.com" forKey:@"email"];
        [managedObject setValue:@0 forKey:@"userType"];
        
        return YES;
    }];
}

-(void)printUser:(NSManagedObject *)user
{
    NSLog(@"Name: %@ %@", [user valueForKey:@"firstName"], [user valueForKey:@"lastName"]);
    NSLog(@"Email: %@", [user valueForKey:@"email"]);
    NSLog(@"Username: %@", [user valueForKey:@"username"]);
    NSLog(@"-----");

}

-(void)testUpdate
{
    [[TSCoreDataManager sharedManager]updateObjectsFromEntity:@"TSUser"
                                                        where:@[@"firstName"]
                                                    isEqualTo:@[@"manuel"]
                                              withUpdateBlock:^(NSManagedObject *managedObject){
                                                  
                                                  XCTAssertNotNil(managedObject);
                                                  
                                                  [managedObject setValue:@"Camacho Rivera" forKey:@"lastName"];
    }];
}

-(void)testDelete
{
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSUser" where:@[@"firstName"] isEqualTo:@[@"manuel"]];

    for (NSManagedObject *user in users)
    {
        if([[user valueForKey:@"lastName"] isEqualToString:@"Camacho Rivera"])
        {
            [[TSCoreDataManager sharedManager] deleteManagedObject:user];
        }
    }
}

@end
