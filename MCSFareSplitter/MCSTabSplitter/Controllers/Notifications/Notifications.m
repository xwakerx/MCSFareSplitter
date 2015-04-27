//
//  Notifications.m
//  pruebaSplitter
//
//  Created by MCS on 4/22/15.
//  Copyright (c) 2015 neo.daj.man. All rights reserved.
//

#import "Notifications.h"

@implementation Notifications

+ (id)sharedNotifications {
    static Notifications *notifications = nil;
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

-(UIAlertView *)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertView *alert = [self alertViewWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    return alert;
}

-(UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButton otherButtonTitle:(NSString *)otherButton {
    
    UIAlertView *alert = [self alertViewWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButton otherButtonTitles:[[NSArray alloc]initWithObjects:otherButton, nil]];
    return alert;
}

-(UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButton otherButtonTitles:(NSArray *)titleButtons {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButton otherButtonTitles: nil];
    if (titleButtons) {
        for (int i=0; i<titleButtons.count; i++) {
            if ([[titleButtons objectAtIndex:i]isKindOfClass:[NSString class]]) {
                [alert addButtonWithTitle:[titleButtons objectAtIndex:i]];
            }
        }
    }
    return alert;
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
