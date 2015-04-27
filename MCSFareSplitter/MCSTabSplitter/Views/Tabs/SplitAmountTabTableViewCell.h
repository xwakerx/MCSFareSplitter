//
//  SplitTabTableViewCell.h
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateTotalAmountDelegate <NSObject>

@required
-(void)updateTotalAmountWithValue:(NSNumber*)val atIndex:(NSInteger)index;
@required
-(void)updateTotalAmountWithPercentage:(double)percentage atIndex:(NSInteger)index;

@end

@interface SplitAmountTabTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblUser;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UITextField *tfPercentage;
@property (weak, nonatomic) IBOutlet UILabel *lblItems;

@property (nonatomic) NSInteger index;
@property (nonatomic) id<UpdateTotalAmountDelegate> delegate;

@end
