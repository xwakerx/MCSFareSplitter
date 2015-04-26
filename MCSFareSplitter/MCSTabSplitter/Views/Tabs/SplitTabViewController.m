//
//  SplitTabViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SplitTabViewController.h"
#import "AppDelegate.h"

static const int BTN_EQUAL = 0;
static const int BTN_AMOUNTS = 1;
static const int BTN_PERCENTAGE = 2;
static const int BTN_ITEMS = 3;

@interface SplitTabViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsSplitType;

@property (nonatomic) NSNumber *currSplitType;

@end

@implementation SplitTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectButtonWithIndex:BTN_EQUAL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapTypeChanged:(id)sender {
    [self selectButton:sender];
}

- (void)selectButtonWithIndex:(int) indexBtn{
    for(UIButton *btn in self.btnsSplitType){
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        btn.tintColor = [UIColor lightGrayColor];
        [btn setImage:[btn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    UIButton *selectedBtn = self.btnsSplitType[indexBtn];
    selectedBtn.tintColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
    [selectedBtn setImage:[selectedBtn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.currSplitType = [NSNumber numberWithInt:indexBtn];
}

- (void)selectButton:(UIButton *) selectedBtn{
    NSUInteger count = 0;
    for(UIButton *btn in self.btnsSplitType){
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        btn.tintColor = [UIColor lightGrayColor];
        [btn setImage:[btn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        if(btn == selectedBtn){
            self.currSplitType = [NSNumber numberWithInteger: count];
        }
        count++;
    }
    selectedBtn.tintColor = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainTintColor;
    [selectedBtn setImage:[selectedBtn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

@end
