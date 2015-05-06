//
//  TSItemDetailTableViewController.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/6/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSItem;

@protocol TSItemDetailTableViewControllerDelegate <NSObject>

-(void)saveItem:(TSItem *)item;

@end

@interface TSItemDetailTableViewController : UITableViewController

@property (nonatomic, strong) TSItem *item;
@property (nonatomic, assign) id <TSItemDetailTableViewControllerDelegate> delegate;

@end