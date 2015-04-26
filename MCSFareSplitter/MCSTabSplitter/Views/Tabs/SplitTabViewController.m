//
//  SplitTabViewController.m
//  MCSTabSplitter
//
//  Created by MCS on 4/24/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SplitTabViewController.h"

static const int BTN_EQUAL = 0;
static const int BTN_AMOUNTS = 1;
static const int BTN_PERCENTAGE = 2;
static const int BTN_ITEMS = 3;

@interface SplitTabViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsSplitType;

@end

@implementation SplitTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIButton *btn in self.btnsSplitType){
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        btn.imageView.image = btn.imageView.image;
    }
    
    
    //[[self.itemImageButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
    //[self.itemImageButton setImage:[UIImage imageNamed:stretchImage] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
