//
//  TabsTableViewController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabsViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *tabs;
-(IBAction)addNewTab:(UIStoryboardSegue*)segue;
@end
