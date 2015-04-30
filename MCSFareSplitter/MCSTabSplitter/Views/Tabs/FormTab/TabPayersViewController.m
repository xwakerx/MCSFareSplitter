
//
//  TabPayersViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/29/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TabPayersViewController.h"

@interface TabPayersViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@end

@implementation TabPayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnCancel.hidden = YES;
    self.btnCancel.tintColor = [UIColor darkGrayColor];
    [self.btnCancel setImage:[self.btnCancel.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.btnSearchIcon.tintColor = [UIColor grayColor];
    [self.btnSearchIcon setImage:[self.btnSearchIcon.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Control
- (IBAction)onSearchClicked:(id)sender {
    self.btnSearch.hidden=YES;
    self.btnCancel.alpha=0;
    self.btnCancel.hidden=NO;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.lblSearch.alpha=0;
                         self.btnSearchIcon.alpha=0;
                         self.btnCancel.alpha=1;
                         CGRect frame = self.tfSearch.frame;
                         frame.size.width = frame.size.width - self.btnCancel.frame.size.width - 8;
                         self.tfSearch.frame=frame;
                     }
                     completion:^(BOOL finished){
                         self.btnSearchIcon.hidden=YES;
                         self.lblSearch.hidden=YES;
                         [self.tfSearch becomeFirstResponder];
                     }];
}

- (IBAction)onCancelClicked:(id)sender {
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
                     }
                     completion:^(BOOL finished){
                         self.btnCancel.hidden=YES;
                     }];
}

@end
