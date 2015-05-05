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

#import "TSUtilities.h"
#import "TSCDUser.h"
#import "TSCDTab.h"
#import "TSCDUserTabSplit.h"

static NSString *const kUserEntity = @"TSCDUser";
static NSString *const kTabEntity = @"TSCDTab";

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
                                                   user.userType = @2;
                                                   
                                                   return YES;
                                               }
                                               return NO;
                                           }];
}

-(void)insertUserTabSplitWithUser:(TSCDUser *)user withRole:(NSNumber *)role;
{
    [[TSCoreDataManager sharedManager] insertObjectWithEntity:@"TSCDUserTabSplit"
                                           withInsertionBlock:^(NSManagedObject *managedObject){
                                               if([managedObject isKindOfClass:[TSCDUserTabSplit class]])
                                               {
                                                   TSCDUserTabSplit *split = (TSCDUserTabSplit *)managedObject;
                                                   
                                                   split.initialAmount = @20.0;
                                                   split.amount = @20.0;
                                                   split.userTabType = role;
                                                   split.user = user;
                                                
                                                   return YES;
                                               }
                                               return NO;
                                           }];
}

-(void)testInsertTab
{
    for(NSInteger i = 0; i < 10; i++)
    {
        [self testInsert];
    }
    
    NSArray *users = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:kUserEntity
                                                                         where:@[@"userType"]
                                                                     isEqualTo:@[@2]
                                                             sortedByAttribute:@"lastName"];
    
    NSInteger i = 0;
    for (TSCDUser *user in users)
    {
        if(i % 2 == 0)
        {
            [self insertUserTabSplitWithUser:user withRole:@0];
        }
        else
        {
            [self insertUserTabSplitWithUser:user withRole:@1];
        }
        i++;
    }

    NSArray *participants = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSCDUserTabSplit"
                                                                                where:@[@"userTabType"]
                                                                            isEqualTo:@[@0]];
    
    NSArray *payers = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:@"TSCDUserTabSplit"
                                                                          where:@[@"userTabType"]
                                                                      isEqualTo:@[@1]];
    
    NSArray *allUsers = [participants arrayByAddingObjectsFromArray:payers];
    
    
    NSDecimalNumber *totalAmount = [TSUtilities decimalNumberWithNumber:@0];
    
    for (TSCDUserTabSplit *split in payers)
    {
        totalAmount = [totalAmount decimalNumberByAdding:[TSUtilities decimalNumberWithNumber:split.initialAmount]];
    }
    
    [[TSCoreDataManager sharedManager] insertObjectWithEntity:kTabEntity
                                           withInsertionBlock:^(NSManagedObject *managedObject){
                                               if([managedObject isKindOfClass:[TSCDTab class]])
                                               {
                                                   TSCDTab *tab = (TSCDTab *)managedObject;
                                                   
                                                   tab.title        = @"Tab title";
                                                   tab.memo         = @"Tab memo";
                                                   tab.totalAmount  = (NSNumber *)totalAmount;
                                                   tab.currency     = @"MXN";
                                                   tab.date         = [NSDate date];
                                                   tab.splitMethod  = @0;
                                                   tab.status       = @0;
                                                   
                                                   for (TSCDUserTabSplit *split in allUsers)
                                                   {
                                                       [tab addUsersObject:split];
                                                       split.tab = tab;
                                                   }
                                                   
                                                   return YES;
                                               }
                                               return NO;
                                           }];
}

-(void)testFetchTab
{
    NSArray *tabs = [[TSCoreDataManager sharedManager] fetchObjectsFromEntity:kTabEntity
                                                                         where:@[@"currency"]
                                                                     isEqualTo:@[@"MXN"]
                                                             sortedByAttribute:@"title"];
    
    XCTAssertNotNil(tabs);
    
    NSLog(@"**************");
    NSLog(@"Fetch returned %li Tabs:", (long)tabs.count);
    for (TSCDTab *tab in tabs)
    {
        [self printTabs:tab];
        for (TSCDUserTabSplit *split in tab.users)
        {
            [self printUser:split.user];
        }
    }
    NSLog(@"**************");
}

-(void)printUser:(TSCDUser *)user
{
    NSLog(@"Name: %@ %@", user.firstName, user.lastName);
    NSLog(@"Email: %@", user.email);
    NSLog(@"Username: %@",user.username);
    NSLog(@"-----");
}

-(void)printTabs:(TSCDTab *)tab
{
    NSLog(@"Title: %@", tab.title);
    NSLog(@"Memo: %@", tab.memo);
    NSLog(@"Amount: %@",tab.totalAmount);
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
