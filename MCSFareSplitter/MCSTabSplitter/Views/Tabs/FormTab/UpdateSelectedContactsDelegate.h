//
//  UpdateSelectedContactsDelegate.h
//  MCSTabSplitter
//
//  Created by MCS on 5/5/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

@protocol UpdateSelectedContactsDelegate <NSObject>

@required
-(void)loadTabSplitUsersWithUsersArray:(NSArray*)users;

@required
-(void)loadTabSplitPayersWithUsersArray:(NSArray*)users;

@end
