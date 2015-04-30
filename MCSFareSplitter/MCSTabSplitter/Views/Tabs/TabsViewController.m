//
//  TabsTableViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TabsViewController.h"
#import "TSTabController.h"
#import "TSUserTabSplit.h"
#import "TSTabUser.h"
#import "TSUser.h"
#import "TSTab.h"
#import "SplitTabViewController.h"
#import "FormTabTableViewController.h"

@interface TabsViewController ()

@end

@implementation TabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.tabs = [[TSTabController getUserTabs] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tabs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    TSTab *tab = [self.tabs objectAtIndex:indexPath.row];
    cell.textLabel.text = [tab title];
    
    return cell;
}

-(IBAction)addNewTab:(UIStoryboardSegue*)segue{
    SplitTabViewController *splitV = segue.sourceViewController;
    TSTab *newTab = splitV.tab;
    
    //TODO: check this logic .....
//    for (TSUserTabSplit *usrTS in newTab.users) {
//        if ([usrTS.user.email isEqualToString:[TSUser sharedUser].user.email]) {
//            [TSUser sharedUser].user.splitTabs = @[usrTS];
//        }
//    }
    [self.tabs addObject:newTab];
    [self.tableView reloadData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqualToString: @"addTab"]){
        FormTabTableViewController *formTabVC = segue.destinationViewController;
        formTabVC.currTab = [[TSTab alloc] init];
    }else if([segue.identifier  isEqualToString: @"showTab"]){
        UITableViewCell *cell = sender;
        NSIndexPath *index = [self.tableView indexPathForCell:cell];
        
        SplitTabViewController *splitView = segue.destinationViewController;
        splitView.tab = [self.tabs objectAtIndex:index.row];
    }
    
}

@end
