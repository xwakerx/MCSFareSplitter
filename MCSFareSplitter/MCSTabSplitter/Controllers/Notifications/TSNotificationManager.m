//
//  Notifications.m
//  pruebaSplitter
//
//  Created by MCS on 4/22/15.
//  Copyright (c) 2015 neo.daj.man. All rights reserved.
//

#import "TSNotificationManager.h"
#import "TSDefinitions.h"

@interface TSNotificationManager ()

@property (nonatomic, strong) NSMutableArray *notifications;
@end

@implementation TSNotificationManager

+ (id)sharedNotifications {
    static TSNotificationManager *notifications = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notifications = [super init];
        notifications.notifications = [NSMutableArray new];
    });
    return notifications;
}

- (id)init {
    [NSException raise:@"TSSingletonException" format:@"You can't access to the init in a singleton"];
    return nil;
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

-(void)sendLocalNotification:(NSString*)message {
    [self sendLocalNotificationWithFireDate:[NSDate dateWithTimeIntervalSinceNow:10] alertBody:message soundFile:@"SoundRupias.mp3"];
    
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

#pragma mark - PushNotifications

-(void)notificationReceivedWithTitle:(NSString *)title withMessage:(NSString *)message andType:(TSNotificationType *)type{
    TSNotification *notification = [TSNotification new];
    
    [notification setTitle:title];
    [notification setMessage:message];
    [notification setType:type];
    
    [self.notifications addObject:notification];
}

-(void)showNotifications{
    for (TSNotification *notification in self.notifications) {
        NSLog(@"Title:%@ \nMessage:%@\nType:%ul",notification.title, notification.message, notification.type);
    }
}


-(void)resetBadgeNumber {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end