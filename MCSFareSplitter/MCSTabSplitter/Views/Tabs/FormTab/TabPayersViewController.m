
//
//  TabPayersViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TabPayersViewController.h"
#import "AppDelegate.h"
#import "TSTabUser.h"
#import "TSContactsManager.h"
#import "AddGhostTableViewCell.h"
#import "TSUtilities.h"
#import "PayerTableViewCell.h"
#import "TSUserTabSplit.h"

static NSString *ciContactToAdd = @"contactToAddCell";
static NSString *ciPayer = @"payerCell";
static NSString *ciGhostPayer = @"ghostPayerCell";
static NSString *ciAddGhost = @"addGhostCell";

@interface TabPayersViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITableView *tvPayers;
@property (weak, nonatomic) IBOutlet UITableView *tvSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalAmount;

@property (nonatomic) bool isSearching;

@end

@implementation TabPayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnCancel.hidden = YES;
    self.btnCancel.tintColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
    [self.btnCancel setImage:[self.btnCancel.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.btnSearchIcon.tintColor = [UIColor grayColor];
    [self.btnSearchIcon setImage:[self.btnSearchIcon.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.tvSearch.hidden=YES;
    self.isSearching = false;
    if(self.payers==nil){self.payers = [NSMutableArray array];}
    if(self.contactsToAdd==nil){self.contactsToAdd = [NSMutableArray array];}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table views management

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tvPayers){
        return self.payers.count;
    }else if(tableView == self.tvSearch){
        return self.contactsToAdd.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tmpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ciContactToAdd];
    TSTabUser *tmpUser;
    
    if(tableView == self.tvPayers){
        NSString *cellIdentifier = ciPayer;
        TSUserTabSplit *tmpSplitUser = [self.payers objectAtIndex:indexPath.row];
        if(tmpSplitUser.user.userType == TSTabUser.TSUserTypeGhost){
            cellIdentifier=ciGhostPayer;
        }
        PayerTableViewCell *cell = [self.tvPayers dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil){
            cell = [[PayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.lblName.text = tmpSplitUser.user.fullName;
        cell.lblEmail.text = tmpSplitUser.user.email;
        
        cell.tabUser = tmpSplitUser;
        cell.tpVC = self;
        
        [cell setDoneButton];
        
        return cell;
    }else if(tableView == self.tvSearch){
        tmpUser = [self.contactsToAdd objectAtIndex:indexPath.row];
        if(tmpUser.userType == TSTabUser.TSUserTypeAction){
            AddGhostTableViewCell *cell = [self.tvSearch dequeueReusableCellWithIdentifier:ciAddGhost];
            if(cell == nil){
                cell = [[AddGhostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ciAddGhost];
            }
            cell.lblTitle.text = [NSString stringWithFormat:@"Add \"%@\" as payer",tmpUser.email];
            return cell;
        }else{
            tmpCell = [self.tvSearch dequeueReusableCellWithIdentifier:ciContactToAdd];
            if(tmpCell==nil){
                tmpCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ciContactToAdd];
            }
            
            TSUserTabSplit *tmptmpUser = [[TSUserTabSplit alloc] initWithPayerUser:tmpUser andTab:nil withAmount:@0];
            if([self userIsPayer: tmptmpUser]){
                tmpCell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                tmpCell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    
    if(tmpUser.userType == TSTabUser.TSUserTypeGhost){
        tmpCell.textLabel.text = tmpUser.email;
        tmpCell.detailTextLabel.text = @"";
    }else{
        tmpCell.textLabel.text = tmpUser.fullName;
        tmpCell.detailTextLabel.text = tmpUser.email;
    }
    
    return tmpCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tvSearch){
        //TSTabUser *tmpUser = [self.contactsToAdd objectAtIndex:indexPath.row];
        TSUserTabSplit *tmpUser = [[TSUserTabSplit alloc] initWithPayerUser:[self.contactsToAdd objectAtIndex:indexPath.row] andTab:nil withAmount:@0];
        if(tmpUser.user.userType == [TSTabUser TSUserTypeAction]){
            if(![self userIsPayer:tmpUser]){
                if([TSUtilities isValidEmailAddress:tmpUser.user.email]){
                    tmpUser = [[TSUserTabSplit alloc] initWithPayerUser:[[TSTabUser alloc] initGhostUserWithMail:tmpUser.user.email] andTab:nil withAmount:@0];
                    [self.payers addObject:tmpUser];
                    [self.tvPayers reloadData];
                    [self onCancelClicked:tableView];
                }else{
                    [TSUtilities showAlertInController:self withMessage:NSLocalizedString(@"must_enter_valid_email", nil)];
                }
            }else{
                [TSUtilities showAlertInController:self withMessage:[NSString stringWithFormat: NSLocalizedString(@"is_already_payer", nil), tmpUser.user.email]];
            }
        }else{
            tmpUser = [[TSUserTabSplit alloc] initWithPayerUser:tmpUser.user andTab:nil withAmount:@0];
            [self.payers addObject:tmpUser];
            [self.tvPayers reloadData];
            [self onCancelClicked:tableView];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView == self.tvSearch){
        [self.tfSearch resignFirstResponder];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tvSearch){
        TSTabUser *tmpUser = [self.contactsToAdd objectAtIndex:indexPath.row];
        if(tmpUser.userType == TSTabUser.TSUserTypeAction){
            return 30;
        }
    }
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.tvPayers){
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.tvPayers){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [self.payers removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

#pragma mark - textfield management

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchContact];
    return YES;
}

- (IBAction)onSearchChanged:(id)sender {
    [self searchContact];
}

#pragma mark - UI Control
- (IBAction)onSearchClicked:(id)sender {
    self.isSearching = true;
    self.btnSearch.hidden=YES;
    self.btnCancel.alpha=0;
    self.btnCancel.hidden=NO;
    self.tvSearch.hidden=NO;
    
    [self searchContact];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.lblSearch.alpha=0;
                         self.btnSearchIcon.alpha=0;
                         self.btnCancel.alpha=1;
                         CGRect frame = self.tfSearch.frame;
                         frame.size.width = frame.size.width - self.btnCancel.frame.size.width - 8;
                         self.tfSearch.frame=frame;
                         self.tvSearch.alpha=1;
                     }
                     completion:^(BOOL finished){
                         self.btnSearchIcon.hidden=YES;
                         self.lblSearch.hidden=YES;
                         [self.tfSearch becomeFirstResponder];
                     }];
}

- (IBAction)onCancelClicked:(id)sender {
    self.isSearching = false;
    self.btnSearch.hidden=NO;
    self.tfSearch.text=@"";
    [self.tfSearch resignFirstResponder];
    self.btnSearchIcon.hidden=NO;
    self.lblSearch.hidden=NO;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.lblSearch.alpha=1;
                         self.btnSearchIcon.alpha=1;
                         self.btnCancel.alpha=0;
                         CGRect frame = self.tfSearch.frame;
                         frame.size.width = frame.size.width + self.btnCancel.frame.size.width + 8;
                         self.tfSearch.frame=frame;
                         frame = self.tvSearch.frame;
                         frame.size.height = 0;
                         self.tvSearch.frame = frame;
                         self.tvSearch.alpha=0;
                     }
                     completion:^(BOOL finished){
                         self.btnCancel.hidden=YES;
                         self.tvSearch.hidden=YES;
                     }];
}

- (IBAction)doneClicked:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark - other methods

-(void) searchContact{
    NSString *stringToSearch = self.tfSearch.text;
    NSArray *tmpArray;
    if(![stringToSearch isEqualToString:@""]){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.fullName contains[cd] %@ or self.email contains[cd] %@", stringToSearch, stringToSearch];
        tmpArray = [[[TSContactsManager sharedManager] phoneContacts] filteredArrayUsingPredicate:predicate];
    }else{
        tmpArray = [[TSContactsManager sharedManager] phoneContacts];
    }
    self.contactsToAdd = [NSMutableArray array];
    if(![stringToSearch isEqualToString:@""]){
        [self.contactsToAdd addObject:[[TSTabUser alloc] initActionUserWithMail:stringToSearch]];
    }
    for(TSTabUser *user in tmpArray){
        TSUserTabSplit *tmpUser = [[TSUserTabSplit alloc] initWithPayerUser:user andTab:nil withAmount:@0];
        if(![self userIsPayer:tmpUser]){
            [self.contactsToAdd addObject:user];
        }
    }
    [self.tvSearch reloadData];
}


-(bool) userIsPayer: (TSUserTabSplit *) user{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.user.email like[cd] %@", user.user.email];
    NSArray *tmpArray = [self.payers filteredArrayUsingPredicate:predicate];
    if(tmpArray.count>0){
        return true;
    }else{
        return false;
    }
}

-(void)updateTotalAmount{
    long double total = 0.0;
    for(TSUserTabSplit *tabUser in self.payers){
        total = total + [tabUser.amount doubleValue];
    }
    self.lblTotalAmount.text = [TSUtilities getCurrencyString:[NSNumber numberWithDouble:total]];
}

@end
