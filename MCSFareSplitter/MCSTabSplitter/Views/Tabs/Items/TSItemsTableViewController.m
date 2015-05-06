//
//  TSItemsTableViewController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/6/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSItemsTableViewController.h"
#import "TSItemDetailTableViewController.h"
#import "TSItem.h"

@interface TSItemsTableViewController () <TSItemDetailTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *addItemBtn;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TSItemsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"itemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    TSItem *item = [self.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%li)", item.detail, (long)item.quantity];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f",[item.cost floatValue]];;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[TSItemDetailTableViewController class]])
    {
        TSItemDetailTableViewController *itemDetailVC = [segue destinationViewController];
        
        NSInteger selectedIndex = self.tableView.indexPathForSelectedRow.row;
        
        itemDetailVC.item = [self.items objectAtIndex:selectedIndex];
        
        itemDetailVC.delegate = self;
    }
}

#pragma mark - TSItemDetailTableViewControllerDelegate

-(void)saveItem:(TSItem *)item
{
    [self addItem:item];
}

#pragma mark - Private methods

-(void)addItem:(TSItem *)item
{
    if(!self.items)
    {
        self.items = [NSMutableArray array];
        [self.items addObject:item];
    }
}

@end
