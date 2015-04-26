//
//  TSTabController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTabController.h"
#import "TSUserTabSplit.h"
#import "TSTabUser.h"
#import "TSTab.h"

@implementation TSTabController

-(NSArray*) getUserTabs {
    NSArray *tabs = nil;
    
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
    
    return [[TSTab alloc] init];
}

-(NSArray*) generateMockUsers {
    
    TSTabUser *tu1 = [[TSTabUser alloc] initWithEmail:@"usr1@yahoo.com" withFirstName:@"User" withMiddleName:@"I" withLastName:@"Test" userType:@1];
    TSTabUser *tu2 = [[TSTabUser alloc] initWithEmail:@"usr2@yahoo.com" withFirstName:@"User" withMiddleName:@"II" withLastName:@"Test" userType:@1];
    NSArray* users = [[NSArray alloc] initWithObjects:
                     tu1, tu2, nil];
    
    return users;
}

@end
