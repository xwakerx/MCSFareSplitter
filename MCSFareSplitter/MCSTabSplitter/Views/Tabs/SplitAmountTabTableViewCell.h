//
//  SplitTabTableViewCell.h
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitAmountTabTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfPercentage;
@property (weak, nonatomic) IBOutlet UILabel *lblItems;

@end
