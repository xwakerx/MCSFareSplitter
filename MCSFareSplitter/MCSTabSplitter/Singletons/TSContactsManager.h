//
//  TSContactsManager.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kContactsAccessPermissionsWereGranted = @"kContactsAccessPermissionsWereGranted";
static NSString *const kContactsAccessPermissionsWereDenied = @"kContactsAccessPermissionsWereDenied";

@interface TSContactsManager : NSObject

@property (nonatomic, assign, readonly) BOOL hasPermissions;

+ (id)sharedManager;
-(NSArray *)phoneContacts;
-(void)requestPermissions;

@end