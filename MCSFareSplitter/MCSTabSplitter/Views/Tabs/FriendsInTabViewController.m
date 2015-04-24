//
//  FriendsInTabViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/23/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "FriendsInTabViewController.h"
#import "TSTabUser.h"
#import "AppDelegate.h"

@interface FriendsInTabViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITableView *tvContactsInTab;
@property (weak, nonatomic) IBOutlet UITableView *tvAllContacts;

@property (nonatomic) NSMutableArray *contactsInTab, *allContacts;
@property (nonatomic) NSString *ciContactsInTab, *ciAllContacts;

@end

@implementation FriendsInTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contactsInTab = [NSMutableArray array];
    self.allContacts = [NSMutableArray array];
    
    self.ciContactsInTab = @"ciContactsInTab";
    self.ciAllContacts = @"ciAllContacts";
    
    TSTabUser *tmpUser = [[TSTabUser alloc] init];
    tmpUser.firstName = @"Jhon";
    tmpUser.lastName = @"Smith";
    tmpUser.email = @"jhon.smith@gmail.com";
    tmpUser.userType = [TSTabUser TSUserTypeFacebook];
    [self.allContacts addObject:tmpUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Contact's email

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Contacts table management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tvContactsInTab){
        return self.contactsInTab.count;
    }else{
        return self.allContacts.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == self.tvContactsInTab){
        return NSLocalizedString(@"contacts_in_tab", nil);
    }else{
        return NSLocalizedString(@"all_contacts", nil);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tmpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.ciContactsInTab];
    TSTabUser *tmpUser;
    if(tableView == self.tvContactsInTab){
        tmpCell = [self.tvContactsInTab dequeueReusableCellWithIdentifier:self.ciContactsInTab];
        if(tmpCell==nil){
            tmpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.ciContactsInTab];
        }
        tmpCell.accessoryType = UITableViewCellAccessoryCheckmark;
        tmpCell.tintColor =  ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
        tmpUser = [self.contactsInTab objectAtIndex:indexPath.row];
    }else{
        tmpCell = [self.tvAllContacts dequeueReusableCellWithIdentifier:self.ciAllContacts];
        if(tmpCell==nil){
            tmpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.ciAllContacts];
        }
        tmpCell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Icon Plus" ]];
        tmpUser = [self.allContacts objectAtIndex:indexPath.row];
    }
    
    if(tmpUser.userType == [TSTabUser TSUserTypeGhost]){
        tmpCell.textLabel.text = tmpUser.email;
        tmpCell.imageView.image = [UIImage imageNamed:@"Ghost User"];
        tmpCell.detailTextLabel.text = @"";
    }else{
        tmpCell.textLabel.text = tmpUser.description;
        tmpCell.imageView.image = nil;
        tmpCell.detailTextLabel.text = tmpUser.email;
    }
       
    return tmpCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tvContactsInTab){
        TSTabUser *tmpUser = [self.contactsInTab objectAtIndex:indexPath.row];
        [self.contactsInTab removeObjectAtIndex:indexPath.row];
        [self.tvContactsInTab beginUpdates];
        [self.tvContactsInTab deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tvContactsInTab endUpdates];
        if(tmpUser.userType != [TSTabUser TSUserTypeGhost]){
            [self.allContacts insertObject:tmpUser atIndex:0];
            [self.tvAllContacts beginUpdates];
            [self.tvAllContacts insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tvAllContacts endUpdates];
        }
    }else{
        TSTabUser *tmpUser = [self.allContacts objectAtIndex:indexPath.row];
        [self.allContacts removeObjectAtIndex:indexPath.row];
        [self.tvAllContacts beginUpdates];
        [self.tvAllContacts deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tvAllContacts endUpdates];
        [self.contactsInTab insertObject:tmpUser atIndex:0];
        [self.tvContactsInTab beginUpdates];
        [self.tvContactsInTab insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tvContactsInTab endUpdates];
    }
}

#pragma mark - UIControl

- (IBAction)onAddClicked:(id)sender {
    if(![self.tfEmail.text isEqualToString:@""]){
        TSTabUser *tmpUser = [[TSTabUser alloc] initGhostUserWithMail:self.tfEmail.text];
        [self.contactsInTab insertObject:tmpUser atIndex:0];
        [self.tvContactsInTab beginUpdates];
        [self.tvContactsInTab insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tvContactsInTab endUpdates];
        self.tfEmail.text = @"";
        [self.tfEmail resignFirstResponder];
    }
}


@end
