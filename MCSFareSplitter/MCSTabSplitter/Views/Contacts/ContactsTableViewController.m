//
//  ContactsTableViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "TSContactsManager.h"
#import "TSTabUser.h"

static NSString *cellIdentifier = @"contactCellIdentifier";

@interface ContactsTableViewController ()

@property (nonatomic) NSMutableArray *contacts;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contacts = [NSMutableArray arrayWithArray:[[TSContactsManager sharedManager] phoneContacts]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    TSTabUser *tmpUser = [self.contacts objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tmpUser.fullName;
    cell.detailTextLabel.text = tmpUser.email;
    
    return cell;
}

@end
