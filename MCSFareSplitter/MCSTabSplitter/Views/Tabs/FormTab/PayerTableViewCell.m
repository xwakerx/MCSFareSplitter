//
//  PayerTableViewCell.m
//  MCSTabSplitter
//
//  Created by MCS on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "PayerTableViewCell.h"
#import "TSUtilities.h"

@implementation PayerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDoneButton{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.tfAmount.inputAccessoryView = keyboardDoneButtonView;
}

- (IBAction)doneClicked:(id)sender{
    [self endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.btnAmount.hidden = NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.btnAmount.hidden = YES;
}

- (IBAction)onAmountChanged:(id)sender {
    NSString *stringAmount = self.tfAmount.text;
    NSCharacterSet *setToRemove = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *setToKeep = [setToRemove invertedSet];
    stringAmount =[[stringAmount componentsSeparatedByCharactersInSet:setToKeep] componentsJoinedByString:@""];
    if(stringAmount.length > 12){
        stringAmount = [stringAmount substringToIndex:12];
    }
    long long enteredAmount = [stringAmount longLongValue];
    self.tabUser.amount = [NSNumber numberWithDouble:((long double)enteredAmount)/100.0];
    self.tfAmount.text = [TSUtilities getCurrencyString:self.tabUser.amount];
    
    [self.tpVC updateTotalAmount];
}

@end
