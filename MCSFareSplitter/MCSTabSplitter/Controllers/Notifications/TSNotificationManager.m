//
//  Notifications.m
//  pruebaSplitter
//
//  Created by MCS on 4/22/15.
//  Copyright (c) 2015 neo.daj.man. All rights reserved.
//

#import "TSNotificationManager.h"

@implementation TSNotificationManager

+ (id)sharedNotifications {
    static TSNotificationManager *notifications = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notifications = [[self alloc] init];
    });
    return notifications;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - AlertViews

+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)viewController
{
    [TSNotificationManager alertViewWithTitle:title andMessage:message withCancelButtonTitle:@"OK" withOtherActions:nil fromViewController:viewController];
}

+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelButtonTitle fromViewController:(UIViewController *)viewController
{
    [TSNotificationManager alertViewWithTitle:title andMessage:message withCancelButtonTitle:cancelButtonTitle withOtherActions:nil fromViewController:viewController];
}

+(void)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message withCancelButtonTitle:(NSString *)cancelButtonTitle withOtherActions:(NSArray *)actions fromViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if(actions)
    {
        for (id action in actions)
        {
            if([action isKindOfClass:[UIAlertAction class]])
            {
                [alertController addAction:(UIAlertAction *)action];
            }
        }
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - LocalNotification

-(void)sendLocalNotification {
    [self sendLocalNotificationWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10] alertBody:@"Ya te depositaron Rupias!" soundFile:@"SoundRupias.mp3"];
    
}

-(void)sendLocalNotificationWithFireDate:(NSDate *)date alertBody:(NSString *)alertBody soundFile:(NSString *)sound {
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.fireDate = date;
    localNotification.alertBody = alertBody;
    if (sound) {
        localNotification.soundName = sound;
    }
    else {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)resetBadgeNumber {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end