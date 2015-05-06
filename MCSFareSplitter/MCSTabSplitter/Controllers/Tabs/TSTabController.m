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
#import "TSUser.h"
#import "TSDefinitions.h"

@implementation TSTabController

+(NSMutableArray*) getUserTabs {
    NSMutableArray *tabs = nil;
    //TODO: get tabs the right way from WWS or CD
    tabs = [self generateMockTabs];
    return tabs;
}

+(NSMutableArray*) getUserTabSplittersForTab:(TSTab*)tab withUsers:(NSArray*)users{
    
    NSMutableArray *usrs = [NSMutableArray new];
    
    for (TSTabUser *usr in users) {
        //convert users to tabsplitusers
        TSUserTabSplit *newUsr = [[TSUserTabSplit alloc] initWithNormalUser:usr andTab:tab withAmount:@0];
        [usrs addObject:newUsr];
    }
    
    
    return usrs;
}

+(NSMutableArray*) getPayersTabSplittersForTab:(TSTab*)tab withUsers:(NSArray*)users{
    
    NSMutableArray *usrs = [NSMutableArray new];
    
    for (TSUserTabSplit *usr in users) {
        TSUserTabSplit *newUsr = [[TSUserTabSplit alloc] initWithNormalUser:usr.user andTab:tab withAmount:usr.initialAmount];
        [usrs addObject:newUsr];
    }
    
    
    return usrs;
}



//Mocks
+(TSTab*)getMockTab {
    
    TSTab *tab = [[TSTab alloc] init];
    tab.date = [NSDate date];
    int num = arc4random_uniform(13)%2;
    tab.title = num == 0 ? @"Walmart G" : @"Costco G";
    tab.totalAmount = [[NSNumber alloc] initWithDouble:(double)num+213];
    tab.currency = [[TSDefinitions currencies] objectAtIndex:0];
    tab.items = [NSMutableArray new];
    tab.participants = [self generateMockUsersForTab:tab];
    
    //Transactions ??
    
    return tab;
    
}

+(NSMutableArray*) generateMockTabs {
    return [[NSMutableArray alloc] initWithObjects:[self getMockTab], [self getMockTab], [self getMockTab], nil];
}

+(NSArray*) generateMockUsersForTab:(TSTab*)tab {
    
    NSArray* users = [[NSArray alloc] initWithObjects:
                      [[TSUserTabSplit alloc] initWithPayerUser:[
                                                            [TSTabUser alloc] initWithEmail:@"usr1@yahoo.com" withFirstName:@"John" withMiddleName:@"J" withLastName:@"Smith" userType:[TSTabUser TSUserTypeContacts]]
                                                    andTab:tab withAmount:@0]
                     ,
                      [[TSUserTabSplit alloc] initWithNormalUser:[[TSTabUser alloc] initWithEmail:@"usr2@yahoo.com" withFirstName:@"Mary" withMiddleName:@"L" withLastName:@"Schulz" userType:[TSTabUser TSUserTypeContacts]]
                                                    andTab:tab withAmount:@0]
                                                            
                     ,
                      nil];
    
    return users;
}

@end
