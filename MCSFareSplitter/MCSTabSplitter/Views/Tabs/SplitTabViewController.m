//
//  SplitTabViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SplitTabViewController.h"
#import "AppDelegate.h"
#import "SplitAmountTabTableViewCell.h"
#import "FriendsInTabViewController.h"
#import "TSTab.h"
#import "TSSplitController.h"
#import "TSUserTabSplit.h"
#import "TSTabUser.h"
#import "ItemsViewController.h"

static const int BTN_EQUAL = 0;
static const int BTN_AMOUNTS = 1;
static const int BTN_PERCENTAGE = 2;
static const int BTN_ITEMS = 3;

static NSString *CELL_ID_EQUAL = @"cellWithAmount";
static NSString *CELL_ID_AMOUNTS = @"cellWithEditableAmount";
static NSString *CELL_ID_PERCENTAGE = @"cellWithPercentage";
static NSString *CELL_ID_ITEMS = @"cellWithItems";

@interface SplitTabViewController () <UpdateTotalAmountDelegate>{
    
    double personalAmount, percentageAmount;
    
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsSplitType;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmountOfTab;
@property (weak, nonatomic) IBOutlet UITableView *tvUsersInTab;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnOptions;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;

@property (nonatomic) NSNumber *currSplitType;


@end

@implementation SplitTabViewController

#pragma mark - View Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    personalAmount = percentageAmount = 0.0;
    [self selectButtonWithIndex:BTN_EQUAL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //TSSplitController *splitController = [[TSSplitController alloc] initWithTab:self.tab];
    self.lblTotalAmountOfTab.text = [NSString stringWithFormat:@"$%.2f", [self.tab.totalAmount floatValue]];
    if (!self.isNew) {
        [self.btnCreate setEnabled:NO];
    }
}

#pragma mark - Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tab.users count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"";
    switch ([self.currSplitType intValue]) {
        case BTN_EQUAL:
            cellIdentifier = @"cellWithAmount";
            break;
            
        case BTN_AMOUNTS:
            cellIdentifier = @"cellWithEditableAmount";
            break;
            
        case BTN_PERCENTAGE:
            cellIdentifier = @"cellWithPercentage";
            break;
            
        case BTN_ITEMS:
            cellIdentifier = @"cellWithItems";
            break;
    }
    SplitAmountTabTableViewCell *cell = [self.tvUsersInTab dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell==nil){
        cell = [[SplitAmountTabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    TSUserTabSplit * usr = [[self.tab users] objectAtIndex:indexPath.row];
    cell.lblUser.text = [usr.user fullName];
    
    cell.tfAmount.placeholder = @"$0.00";
    cell.tfAmount.delegate = self;
    cell.tfPercentage.placeholder = @"0%";
    cell.tfPercentage.delegate = self;
    cell.lblItems.text = @"1 Items";
    self.tvUsersInTab.allowsSelection = NO;
    cell.delegate = self;
    cell.index = indexPath.row;
    
    double cellAmount = 0.0;
    switch ([self.currSplitType intValue]) {
        case BTN_EQUAL:
            cellAmount = ([self.tab.totalAmount doubleValue] / (double) self.tab.users.count);
            cell.lblAmount.text = [NSString stringWithFormat:@"$%.2f", cellAmount];
            
            break;
            
        case BTN_AMOUNTS:
            cellAmount = [[cell.tfAmount text] doubleValue];
            personalAmount += cellAmount;
            break;
            
        case BTN_PERCENTAGE:
            cellAmount = ([[cell.tfPercentage text] doubleValue]/100.0*[self.tab.totalAmount doubleValue]);
            cell.lblAmount.text = [NSString stringWithFormat:@"$%.2f", cellAmount];
            percentageAmount += cellAmount;
            
            break;
            
        case BTN_ITEMS:
            cellIdentifier = @"test ITEMS User";
            self.tvUsersInTab.allowsSelection = YES;
            break;
    }
    
    usr.amount = [NSNumber numberWithDouble: cellAmount];
    [self updateTotalAmount];
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Class Methods

- (IBAction)onTabTypeChanged:(id)sender {
    [self selectButton:sender];
    
    [self.tvUsersInTab reloadData];
}

- (void)selectButtonWithIndex:(int) indexBtn{
    for(UIButton *btn in self.btnsSplitType){
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        btn.tintColor = [UIColor lightGrayColor];
        [btn setImage:[btn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    UIButton *selectedBtn = self.btnsSplitType[indexBtn];
    selectedBtn.tintColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
    [selectedBtn setImage:[selectedBtn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.currSplitType = [NSNumber numberWithInt:indexBtn];
}

- (void)selectButton:(UIButton *) selectedBtn{
    NSUInteger count = 0;
    for(UIButton *btn in self.btnsSplitType){
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        btn.tintColor = [UIColor lightGrayColor];
        [btn setImage:[btn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        if(btn == selectedBtn){
            self.currSplitType = [NSNumber numberWithInteger: count];
        }
        count++;
    }
    selectedBtn.tintColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
    [selectedBtn setImage:[selectedBtn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

-(void)updateTotalAmountWithValue:(NSNumber *)val atIndex:(NSInteger)index{
    TSUserTabSplit * usr = [[self.tab users] objectAtIndex:index];
    usr.amount = val;
    
    [self updateTotalAmount];
    
}

-(void)updateTotalAmountWithPercentage:(double)percentage atIndex:(NSInteger)index{
    double perAmount = [self.tab.totalAmount doubleValue] * percentage/100.0;
    TSUserTabSplit * usr = [[self.tab users] objectAtIndex:index];
    usr.amount = [NSNumber numberWithDouble:perAmount];
    ;
    
    SplitAmountTabTableViewCell *cell = (SplitAmountTabTableViewCell*)[self.tvUsersInTab cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.lblAmount.text = [NSString stringWithFormat:@"$%.2f", perAmount];
    
    [self updateTotalAmount];
}

-(void) updateTotalAmount {
    double amount = 0.0;
    for (TSUserTabSplit *usr in self.tab.users) {
        amount += [[usr amount] doubleValue];
    }
    if (amount != [self.tab.totalAmount doubleValue]) {
        [self.lblTotalAmount setTextColor:[UIColor redColor]];
    }
    else {
        [self.lblTotalAmount setTextColor:[UIColor blackColor]];
    }
    [self.lblTotalAmount setText:[NSString stringWithFormat:@"$%.2f", amount]];
}

-(void)addItem:(UIStoryboardSegue *)segue {
    
    ItemsViewController *itemsVC = segue.sourceViewController;
    if ([self searchForItemWithItem:itemsVC.item] == -1) {
        [self.tab.items addObject:itemsVC.item];
    } else {
        
    }
    
}

-(NSInteger) searchForItemWithItem:(TSItem*)item {
    for (NSInteger i = 0; i <  self.tab.items.count; i++) {
        if(((TSItem*)(self.tab.items[i])).itemId == item.itemId){
            return i;
        }
    }
    return -1;
}

@end
