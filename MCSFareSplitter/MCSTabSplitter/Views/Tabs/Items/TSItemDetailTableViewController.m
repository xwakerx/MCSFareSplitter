//
//  TSItemDetailTableViewController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/6/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSItemDetailTableViewController.h"
#import "TSItem.h"
#import "TSUserTabSplit.h"

@interface TSItemDetailTableViewController ()

@property (nonatomic, weak) IBOutlet UILabel *itemNameLbl;
@property (nonatomic, weak) IBOutlet UITextField *itemQuantityField;
@property (nonatomic, weak) IBOutlet UITextField *itemCostField;
@property (nonatomic, weak) IBOutlet UILabel *itemParticipantsQuantityLbl;

@end

@implementation TSItemDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.item)
    {
        self.itemNameLbl.text = self.item.detail;
        self.itemQuantityField.text = [NSString stringWithFormat:@"%li", (long)self.item.quantity];
        self.itemCostField.text = [NSString stringWithFormat:@"%.2f", [self.item.cost floatValue]];
        self.itemParticipantsQuantityLbl.text = [NSString stringWithFormat:@"%li", (long)self.item.enrolledUsers.count];
    }
    else
    {
        self.item = [[TSItem alloc]initWithCost:@0 andDetail:@""];
        
        self.itemNameLbl.text = @"";
        self.itemQuantityField.text = @"0";
        self.itemCostField.text = @"$0.00";
        self.itemParticipantsQuantityLbl.text = @"0";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveItem:(id)sender
{
    self.item.detail = self.itemNameLbl.text;
    self.item.quantity = [self.itemQuantityField.text integerValue];
    self.item.cost = [NSNumber numberWithDouble:[self.itemCostField.text doubleValue]];

    [self.delegate saveItem:self.item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addParticipantToItem:(TSUserTabSplit *)user
{
    [self.item addUser:user];
}

@end
