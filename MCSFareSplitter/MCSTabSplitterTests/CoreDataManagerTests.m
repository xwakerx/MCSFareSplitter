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
#import "TSCDUser.h"

static NSString *const kUserEntity = @"TSCDUser";

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
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:kUserEntity where:@[@"userType"] isEqualTo:@[@0]];
    XCTAssertNotNil(users);
    
    NSLog(@"**************");
    NSLog(@"Fetch returned %li users:", (long)users.count);
    for (TSCDUser *user in users)
    {
        [self printUser:user];
    }
    NSLog(@"**************");
   
}

-(void)testOrderedFetch
{
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:kUserEntity
                                                                         where:@[@"userType"]
                                                                     isEqualTo:@[@0]
                                                             sortedByAttribute:@"lastName"];
    XCTAssertNotNil(users);
    
    NSLog(@"**************");
    NSLog(@"Fetch returned %li users:", (long)users.count);
    for (TSCDUser *user in users)
    {
        [self printUser:user];
    }
    NSLog(@"**************");
}


-(void)testInsert
{
    [[TSCoreDataManager sharedManager] insertObjectWithEntity:kUserEntity
                                           withInsertionBlock:^(NSManagedObject *managedObject){
                                               if([managedObject isKindOfClass:[TSCDUser class]])
                                               {
                                                   TSCDUser *user = (TSCDUser *)managedObject;
                                                   
                                                   user.firstName = @"Manuel";
                                                   user.lastName = @"Camacho";
                                                   user.username = @"bloq";
                                                   user.email = @"bloqmacr@me.com";
                                                   user.userType = @0;
                                                   
                                                   return YES;
                                               }
                                               return NO;
                                           }];
}

-(void)printUser:(TSCDUser *)user
{
    NSLog(@"Name: %@ %@", user.firstName, user.lastName);
    NSLog(@"Email: %@", user.email);
    NSLog(@"Username: %@",user.username);
    NSLog(@"-----");
    
}

-(void)testUpdate
{
    [[TSCoreDataManager sharedManager]updateObjectsFromEntity:kUserEntity
                                                        where:@[@"firstName"]
                                                    isEqualTo:@[@"manuel"]
                                              withUpdateBlock:^(NSManagedObject *managedObject){
                                                  if([managedObject isKindOfClass:[TSCDUser class]])
                                                  {
                                                      TSCDUser *user = (TSCDUser *)managedObject;
                                                      user.lastName = @"Camacho Rivera";
                                                  }
                                              }];
}

-(void)testDelete
{
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:kUserEntity
                                                                         where:@[@"firstName", @"lastName"]
                                                                     isEqualTo:@[@"manuel", @"Camacho Rivera"]];

    for (NSManagedObject *user in users)
    {
        [[TSCoreDataManager sharedManager] deleteManagedObject:user];
    }
}

@end
