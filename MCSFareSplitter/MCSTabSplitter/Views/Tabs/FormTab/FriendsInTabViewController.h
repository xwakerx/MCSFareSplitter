//
//  FriendsInTabViewController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/23/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateSelectedContactsDelegate <NSObject>

@required
-(void)loadTabSplitUsersWithUsersArray:(NSArray*)users;

@required
-(void)loadTabSplitPayersWithUsersArray:(NSArray*)users;

@end

@interface FriendsInTabViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic) NSMutableArray *contactsInTab;
@property (nonatomic) id<UpdateSelectedContactsDelegate> usersDelegate;
@end
