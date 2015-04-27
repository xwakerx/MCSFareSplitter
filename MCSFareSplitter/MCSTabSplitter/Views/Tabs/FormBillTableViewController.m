//
//  FormVillTableViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/20/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FormBillTableViewController.h"
#import "TSDefinitions.h"
#import "TSCurrency.h"
#import "TSTab.h"
#import "TSUtilities.h"
#import "TSTabController.h"
#import "SplitTabViewController.h"

@interface FormBillTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
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

@property (strong, nonatomic) TSTab *tab;

@end

@implementation FormBillTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tab = [TSTab new];
    
    self.insertTableViewRowAnimation = UITableViewRowAnimationFade;
    self.deleteTableViewRowAnimation = UITableViewRowAnimationFade;
    
    self.hideSectionsWithHiddenRows = YES;
    [self cell:self.tvcCurrencyPicker setHidden:YES];
    [self cell:self.tvcDatePicker setHidden:YES];
    [self reloadDataAnimated:NO];
    
    self.lblCurrency.text = ((TSCurrency *)[[TSDefinitions currencies] objectAtIndex:0]).shortName;
    self.tab.currency = [[TSDefinitions currencies] objectAtIndex:0];
    [self hide:YES button:self.btnCurrency withText:@"" withBGColor:self.tvcCurrencyPicker.backgroundColor];
    self.currencyHidden = true;
    
    self.lblDate.text = [TSUtilities getDateString:[NSDate date]];
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
        [self.btnCurrency setTitle:((TSCurrency *)[[TSDefinitions currencies] objectAtIndex:row]).shortName forState:UIControlStateNormal];
        self.tab.currency = (TSCurrency *)[[TSDefinitions currencies] objectAtIndex:row];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
    if (pickerView == self.pvCurrency)
    {
        returnStr = ((TSCurrency *)[[TSDefinitions currencies] objectAtIndex:row]).shortName;
    }
    
    return returnStr;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int rows = 0;
    if (pickerView == self.pvCurrency)
    {
        rows = (int)[TSDefinitions currencies].count;
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
    [self.btnDate setTitle:[TSUtilities getDateString:self.dpDate.date] forState:UIControlStateNormal];
}

- (IBAction)onAmountChanged:(id)sender {
    NSString *amount = self.tfTotalAmount.text;
    if(![TSUtilities charsAreValidAmount:self.tfTotalAmount.text]){
        for(int i=0;i<amount.length;i++){
            NSString *tmpChar = [NSString stringWithFormat:@"%c",[amount characterAtIndex:i]];
            if(![TSUtilities charsAreValidAmount:tmpChar]){
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

-(void)loadTabSplitUsersWithUsersArray:(NSArray *)users{
    if (users.count > 0) {
        self.tab.users = [TSTabController getUserTabSplittersForTab:self.tab withUsers:users];
        [self.tfUsers setText:[NSString stringWithFormat:@"%li selected.", [self.tab.users count]]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) setupTab{
    self.tab.totalAmount = [NSNumber numberWithDouble:[self.tfTotalAmount.text doubleValue]];
    self.tab.detail = [self.tfTitle text];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"addUsers"]) {
        FriendsInTabViewController *friends = segue.destinationViewController;
        friends.usersDelegate = self;
    } else if([segue.identifier  isEqualToString: @"selectSplitM"]) {
        SplitTabViewController *splitView = segue.destinationViewController;
        splitView.tab = self.tab;
        splitView.isNew = YES;
    }
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier  isEqualToString: @"selectSplitM"]){
        [self setupTab];
        if ([self.tfTotalAmount.text isEqualToString:@""] || [self.tfTitle.text isEqualToString:@""] || self.tab.users.count < 1) {
            [[[UIAlertView alloc] initWithTitle:@"Incomplete Tab" message:@"Please provide a Title, Amount and at least one user." delegate:nil cancelButtonTitle:@"Ok!" otherButtonTitles: nil] show];
            return NO;
        }
    }
    
    return YES;
}

@end
