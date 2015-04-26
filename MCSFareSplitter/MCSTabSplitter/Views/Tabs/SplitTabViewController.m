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

static const int BTN_EQUAL = 0;
static const int BTN_AMOUNTS = 1;
static const int BTN_PERCENTAGE = 2;
static const int BTN_ITEMS = 3;

static NSString *CELL_ID_EQUAL = @"cellWithAmount";
static NSString *CELL_ID_AMOUNTS = @"cellWithEditableAmount";
static NSString *CELL_ID_PERCENTAGE = @"cellWithPercentage";
static NSString *CELL_ID_ITEMS = @"cellWithItems";

@interface SplitTabViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsSplitType;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmountOfTab;
@property (weak, nonatomic) IBOutlet UITableView *tvUsersInTab;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnOptions;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;

@property (nonatomic) NSNumber *currSplitType;

@end

@implementation SplitTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectButtonWithIndex:BTN_EQUAL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
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
    
    cell.lblUser.text = @"User";
    cell.lblAmount.text = @"$0.00";
    cell.tfAmount.text = @"$0.00";
    cell.tfAmount.delegate = self;
    cell.tfPercentage.text = @"0%";
    cell.tfPercentage.delegate = self;
    cell.lblItems.text = @"1 Items";
    self.tvUsersInTab.allowsSelection = NO;
    
    switch ([self.currSplitType intValue]) {
        case BTN_EQUAL:
            cell.lblUser.text = @"test EQUAL User";
            break;
            
        case BTN_AMOUNTS:
            cell.lblUser.text = @"test AMOUNTS User";
            break;
            
        case BTN_PERCENTAGE:
            cellIdentifier = @"test PERCENTAGE User";
            break;
            
        case BTN_ITEMS:
            cellIdentifier = @"test ITEMS User";
            self.tvUsersInTab.allowsSelection = YES;
            break;
    }
    
    
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

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

@end
