//
//  PayerTableViewCell.h
//  MCSTabSplitter
//
//  Created by MCS on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSUserTabSplit.h"
#import "TabPayersViewController.h"

@interface PayerTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnAmount;

@property (strong, nonatomic) TSUserTabSplit *tabUser;
@property (strong, nonatomic) TabPayersViewController *tpVC;

-(void)setDoneButton;

@end
