//
//  TabPayersViewController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabPayersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *payers;
@property (strong, nonatomic) NSMutableArray *contactsToAdd;

-(void)updateTotalAmount;

@end
