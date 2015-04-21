//
//  FormVillTableViewController.m
//  MCSFareSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FormBillTableViewController.h"
#import "FSDefinitions.h"
#import "FSCurrency.h"
#import "FSUtilities.h"

@interface FormBillTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfUsers;
@property (weak, nonatomic) IBOutlet UITextField *tfTotalAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrency;
@property (weak, nonatomic) IBOutlet UITableViewCell *tvcCurrencyPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *pvCurrency;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;
@property (weak, nonatomic) IBOutlet UITableViewCell *tvcDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpDate;

@property (nonatomic) bool currencyHidden;
@property (nonatomic) bool dateHidden;

@end

@implementation FormBillTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.insertTableViewRowAnimation = UITableViewRowAnimationFade;
    self.deleteTableViewRowAnimation = UITableViewRowAnimationFade;
    
    self.hideSectionsWithHiddenRows = YES;
    [self cell:self.tvcCurrencyPicker setHidden:YES];
    [self cell:self.tvcDatePicker setHidden:YES];
    [self reloadDataAnimated:NO];
    
    self.lblCurrency.text = ((FSCurrency *)[[FSDefinitions currencies] objectAtIndex:0]).shortName;
    [self hide:YES button:self.btnCurrency withText:@"" withBGColor:self.tvcCurrencyPicker.backgroundColor];
    self.currencyHidden = true;
    
    self.lblDate.text = [FSUtilities getDateString:[NSDate date]];
    [self hide:YES button:self.btnDate withText:@"" withBGColor:self.tvcDatePicker.backgroundColor];
    self.dateHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Total amount

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Currency Picker

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.pvCurrency)
    {
        [self.btnCurrency setTitle:((FSCurrency *)[[FSDefinitions currencies] objectAtIndex:row]).shortName forState:UIControlStateNormal];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
    if (pickerView == self.pvCurrency)
    {
        returnStr = ((FSCurrency *)[[FSDefinitions currencies] objectAtIndex:row]).shortName;
    }
    
    return returnStr;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int rows = 0;
    if (pickerView == self.pvCurrency)
    {
        rows = (int)[FSDefinitions currencies].count;
    }
    return rows;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

#pragma mark - UI Control

- (IBAction)onCurrencyClicked:(id)sender {
    if(self.currencyHidden){
        self.hideSectionsWithHiddenRows = YES;
        [self cell:self.tvcCurrencyPicker setHidden:NO];
        [self reloadDataAnimated:YES];
        
        [self hide:NO button:self.btnCurrency withText:self.lblCurrency.text withBGColor:self.tvcCurrencyPicker.backgroundColor];
        self.currencyHidden = false;
    }else{
        self.hideSectionsWithHiddenRows = YES;
        [self cell:self.tvcCurrencyPicker setHidden:YES];
        [self reloadDataAnimated:YES];
        
        self.lblCurrency.text = self.btnCurrency.titleLabel.text;
        [self hide:YES button:self.btnCurrency withText:@"" withBGColor:self.tvcCurrencyPicker.backgroundColor];
        self.currencyHidden = true;
    }
}

- (IBAction)onDateClicked:(id)sender {
    if(self.dateHidden){
        self.hideSectionsWithHiddenRows = YES;
        [self cell:self.tvcDatePicker setHidden:NO];
        [self reloadDataAnimated:YES];
        
        [self hide:NO button:self.btnDate withText:self.lblDate.text withBGColor:self.tvcDatePicker.backgroundColor];
        self.dateHidden = false;
    }else{
        self.hideSectionsWithHiddenRows = YES;
        [self cell:self.tvcDatePicker setHidden:YES];
        [self reloadDataAnimated:YES];
        
        self.lblDate.text = self.btnDate.titleLabel.text;
        [self hide:YES button:self.btnDate withText:@"" withBGColor:self.tvcDatePicker.backgroundColor];
        self.dateHidden = true;
    }
}

- (IBAction)onDateChanged:(id)sender {
    [self.btnDate setTitle:[FSUtilities getDateString:self.dpDate.date] forState:UIControlStateNormal];
}

- (IBAction)onAmountChanged:(id)sender {
    NSString *amount = self.tfTotalAmount.text;
    if(![FSUtilities charsAreValidAmount:self.tfTotalAmount.text]){
        for(int i=0;i<amount.length;i++){
            NSString *tmpChar = [NSString stringWithFormat:@"%c",[amount characterAtIndex:i]];
            if(![FSUtilities charsAreValidAmount:tmpChar]){
                amount = [amount stringByReplacingOccurrencesOfString:tmpChar withString:@""];
                i--;
            }
        }
        self.tfTotalAmount.text = amount;
    }
}

- (void) hide:(bool) hide button:(UIButton *) button withText:(NSString *) text withBGColor:(UIColor *)color{
    if(hide){
        [button setTitle:@"" forState:UIControlStateNormal];
        button.backgroundColor = [color colorWithAlphaComponent:0.0];
    }else{
        [button setTitle:text forState:UIControlStateNormal];
        button.backgroundColor = [color colorWithAlphaComponent:1.0];
    }
}

@end
