//
//  SplitTabTableViewCell.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SplitAmountTabTableViewCell.h"

@implementation SplitAmountTabTableViewCell

/*- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/

- (IBAction)updateTotalAmount:(id)sender {
    if (self.delegate != nil) {
        [self.delegate updateTotalAmountWithValue:[NSNumber numberWithDouble:[self.tfAmount.text doubleValue]] atIndex:self.index];
    }
}

- (IBAction)updateTotalAmounWithPercentage:(id)sender {
    
    if (self.delegate != nil) {
        [self.delegate updateTotalAmountWithPercentage:[self.tfPercentage.text doubleValue] atIndex:self.index];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
