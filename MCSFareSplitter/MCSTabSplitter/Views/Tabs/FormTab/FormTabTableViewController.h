//
//  FormVillTableViewController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"
#import "FriendsInTabViewController.h"
#import "TSTab.h"

@interface FormTabTableViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UpdateSelectedContactsDelegate>

@property (strong, nonatomic) TSTab *currTab;

@end
