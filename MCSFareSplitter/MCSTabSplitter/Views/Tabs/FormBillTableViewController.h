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

@interface FormBillTableViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UpdateSelectedContactsDelegate>

@end
