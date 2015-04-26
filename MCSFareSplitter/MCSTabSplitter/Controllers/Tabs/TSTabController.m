//
//  TSTabController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTabController.h"
#import "TSUserTabSplit.h"
#import "TSCurrency.h"
#import "TSTabUser.h"
#import "TSTab.h"
#import "TSCurrency.h"

@implementation TSTabController

-(NSArray*) getUserTabs {
    NSArray *tabs = nil;
    //TODO: get tabs the right way from WWS or CD
    tabs = [self generateMockTabs];
    return tabs;
}

-(NSArray*) getUserTabSplittersForTab:(TSTab*)tab withUsers:(NSArray*)users{
    
    NSMutableArray *usrs = [NSMutableArray new];
    for (TSTabUser *usr in users) {
        //convert users to tabsplitusers
        TSUserTabSplit *newUsr = [[TSUserTabSplit alloc] initWithUser:usr andTab:tab withAmount:@0];
        [usrs addObject:newUsr];
    }
    return [usrs mutableCopy];
}



//Mocks
-(TSTab*)getMockTab {
    
    TSTab *tab = [[TSTab alloc] init];
    tab.date = [NSDate date];
    int num = arc4random_uniform(100)%2;
    tab.detail = num == 0 ? @"Walmart G" : @"Costco G";
    tab.totalAmount = [[NSNumber alloc] initWithDouble:(double)num+213];
    tab.users = [self generateMockUsers];
    tab.currency = [[TSCurrency alloc] initWithShortName:@"USD" withFullName:@"US DOLLAR"];
    tab.items = @[];
    
    //Transactions ??
    
    return tab;
    
}

-(NSArray*) generateMockTabs {
    return [[NSArray alloc] initWithObjects:[self getMockTab], [self getMockTab], [self getMockTab], nil];
}

-(NSArray*) generateMockUsers {
    
    NSArray* users = [[NSArray alloc] initWithObjects:
                     [[TSTabUser alloc] initWithEmail:@"usr1@yahoo.com" withFirstName:@"User" withMiddleName:@"I" withLastName:@"Test" userType:[TSTabUser TSUserTypeContacts]],
                     [[TSTabUser alloc] initWithEmail:@"usr2@yahoo.com" withFirstName:@"User" withMiddleName:@"II" withLastName:@"Test" userType:[TSTabUser TSUserTypeContacts]],
                      nil];
    
    return users;
}

@end
