//
//  Notification.h
//  MCSTabSplitter
//
//  Created by MCS on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSNotification : NSObject

enum {
    TSNotificationTypePaid = 0,
    TSNotificationTypeReminder,
    TSNotificationTypeMessage
};
typedef NSUInteger TSNotificationType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic) TSNotificationType *type;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *amount;

@end
