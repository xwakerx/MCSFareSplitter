//
//  TabTitleTableViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TabTitleTableViewController.h"
#import "FormTabTableViewController.h"

@interface TabTitleTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfTitle;

@end

@implementation TabTitleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tfTitle.text = self.tabTitle;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tfTitle becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UINavigationController *nav = (UINavigationController *)self.parentViewController;
    UIViewController *prevVC = nav.viewControllers[nav.viewControllers.count-1];
    if([prevVC isKindOfClass: [FormTabTableViewController class]]){
        FormTabTableViewController *formTabVC = (FormTabTableViewController *)prevVC;
        formTabVC.currTab.title = self.tfTitle.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    UINavigationController *nav = (UINavigationController *)self.parentViewController;
    [nav popViewControllerAnimated:YES];
    return YES;
}

@end
