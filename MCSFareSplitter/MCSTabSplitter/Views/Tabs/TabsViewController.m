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

@interface TabsViewController ()

@end

@implementation TabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    cell.textLabel.text = [tab detail];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    UITableViewCell *cell = sender;
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    if([segue.identifier  isEqualToString: @"showTab"]) {
        SplitTabViewController *splitView = segue.destinationViewController;
        splitView.tab = [self.tabs objectAtIndex:index.row];
    }
    
}

@end
