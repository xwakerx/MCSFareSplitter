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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) hide:(bool) hide button:(UIButton *) button withText:(NSString *) text withBGColor:(UIColor *)color{
    if(hide){
        [self.btnCurrency setTitle:@"" forState:UIControlStateNormal];
        self.btnCurrency.backgroundColor = [color colorWithAlphaComponent:0.0];
    }else{
        [self.btnCurrency setTitle:text forState:UIControlStateNormal];
        self.btnCurrency.backgroundColor = [color colorWithAlphaComponent:1.0];
    }
}

@end
