//
//  Notifications.h
//  pruebaSplitter
//
//  Created by MCS on 4/22/15.
//  Copyright (c) 2015 neo.daj.man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Notifications : NSObject

@property (nonatomic, strong) NSString *title;

- (UIAlertView *)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message;
- (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButton otherButtonTitle:(NSString *)otherButton;
- (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButton otherButtonTitles:(NSArray *)titleButtons;
- (void)sendLocalNotification;
- (void)resetBadgeNumber;

+ (id)sharedNotifications;
@end
