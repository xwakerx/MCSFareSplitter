//
//  Notifications.h
//  pruebaSplitter
//
//  Created by MCS on 4/22/15.
//  Copyright (c) 2015 neo.daj.man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TSNotificationManager : NSObject

@property (nonatomic, strong) NSString *title;

+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)viewController;
+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelButtonTitle fromViewController:(UIViewController *)viewController;
+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelButtonTitle withOtherActions:(NSArray *)actions fromViewController:(UIViewController *)viewController;

- (void)sendLocalNotification;
- (void)resetBadgeNumber;

+ (id)sharedNotifications;
@end
