//
//  SplitTabViewController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTab.h"

@interface SplitTabViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic) TSTab * tab;
@property (nonatomic) BOOL isNew;

@end
