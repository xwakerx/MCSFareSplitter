//
//  HomeViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "HomeViewController.h"
#import "TSUser.h"
#import "TSUtilities.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblOwed;
@property (weak, nonatomic) IBOutlet UILabel *lblOwes;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UITableView *tvNews;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSNumber *owed = [TSUser sharedUser].user.owed;
    NSNumber *owes = [TSUser sharedUser].user.owe;
    NSNumber *total = (NSNumber *)[[TSUtilities decimalNumberWithNumber:owed] decimalNumberBySubtracting:[TSUtilities decimalNumberWithNumber:owes]];
    
    self.lblOwed.text = [NSString stringWithFormat:@"$%.2f", [owed floatValue]];
    self.lblOwes.text = [NSString stringWithFormat:@"$%.2f", [owes floatValue]];
    if(total.floatValue >= 0)
    {
        self.lblTotal.text = [NSString stringWithFormat:@"$%.2f", [total floatValue]];
    }
    else
    {
        self.lblTotal.text = [NSString stringWithFormat:@"-$%.2f", [total floatValue]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end