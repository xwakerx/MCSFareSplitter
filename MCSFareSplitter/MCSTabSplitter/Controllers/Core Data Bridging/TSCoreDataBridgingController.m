//
//  CoreDataBridgingController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSCoreDataBridgingController.h"

#import "TSCoreDataManager.h"
#import "TSCDAccount.h"
#import "TSCDItem.h"
#import "TSCDNotification.h"
#import "TSCDTab.h"
#import "TSCDTransaction.h"
#import "TSCDUser.h"
#import "TSCDUserTabSplit.h"

#import "TSAccount.h"
#import "TSItem.h"
#import "TSNotification.h"
#import "TSTab.h"
#import "TSTransaction.h"
#import "TSTabUser.h"
#import "TSUserTabSplit.h"

@implementation TSCoreDataBridgingController

+(TSAccount *)localAccountFromCoreDataAccount:(TSCDAccount *)coreDataAccount
{
    TSAccount *localAccount = [[TSAccount alloc]init];
    
    localAccount.email  = coreDataAccount.email;
    localAccount.name   = coreDataAccount.name;
    localAccount.detail = coreDataAccount.detail;
    localAccount.type   = (TSAccountType)[coreDataAccount.type integerValue];
    
    return localAccount;
}

+(TSItem *)localItemFromCoreDataItem:(TSCDItem *)coreDataItem
{
    NSMutableArray *localUsers = [NSMutableArray array];
    
    for (TSCDUserTabSplit *cdUser in coreDataItem.enrolledUsers)
    {
        TSUserTabSplit *localUser = [TSCoreDataBridgingController localSplitFromCoreDataSplit:cdUser];
        [localUsers addObject:localUser];
    }
    
    TSItem *localItem   = [[TSItem alloc]init];
    
    localItem.cost      = coreDataItem.cost;
    localItem.detail    = coreDataItem.detail;
    
    return localItem;
}

+(TSNotification *)localNotificationFromCoreDataNotification:(TSCDNotification *)coreDataNotification
{
    TSNotification *localNotification = [[TSNotification alloc]init];
    
    localNotification.title     = coreDataNotification.title;
    localNotification.message   = coreDataNotification.message;
    localNotification.amount    = coreDataNotification.amount;
    localNotification.type      = (TSNotificationType)[coreDataNotification.type integerValue];
    
    return localNotification;
}

+(TSTab *)localTabFromCoreDataTab:(TSCDTab *)coreDataTab
{
    TSTab *localTab         = [[TSTab alloc]init];
    localTab.totalAmount    = coreDataTab.totalAmount;
    localTab.title          = coreDataTab.title;
    localTab.memo           = coreDataTab.memo;
    localTab.date           = coreDataTab.date;
    localTab.status         = (TSTabStatus)[coreDataTab.status integerValue];
    localTab.splitMethod    = (TSSplitMethod)[coreDataTab.splitMethod integerValue];
    
    NSMutableArray *localItems = [NSMutableArray array];
    for (TSCDItem *cdItem in coreDataTab.items)
    {
        NSMutableArray *localEnrolledUsers = [NSMutableArray array];
        
        for (TSCDUserTabSplit *cdUser in cdItem.enrolledUsers)
        {
            [localEnrolledUsers addObject:[TSCoreDataBridgingController localSplitFromCoreDataSplit:cdUser]];
        }
        
        TSItem *localItem = [[TSItem alloc]initWithCost:cdItem.cost andDetail:cdItem.detail forUsers:[localEnrolledUsers copy]];
        [localItems addObject:localItem];
    }
    
    localTab.items = [localItems copy];
    
    NSMutableArray *localTransactions = [NSMutableArray array];
    for (TSCDTransaction *cdTransaction in coreDataTab.transactions)
    {
        TSTransaction *localTransaction = [TSCoreDataBridgingController localTransactionFromCoreDataTransaction:cdTransaction];
        [localTransactions addObject:localTransaction];
    }
    
    localTab.transactions = [localTransactions copy];
    
    NSMutableArray *localParticipants = [NSMutableArray array];
    NSMutableArray *localPayers = [NSMutableArray array];
    
    for (TSCDUserTabSplit *cdSplit in coreDataTab.users)
    {
        TSUserTabSplit *localSplit = [TSCoreDataBridgingController localSplitFromCoreDataSplit:cdSplit];
        if(localSplit.userTabType == TSUserTypeParticipant)
        {
            [localParticipants addObject:localSplit];
        }
        else
        {
            [localPayers addObject:localSplit];
        }
    }
    
    localTab.participants   = [localParticipants copy];
    localTab.payers         = [localPayers copy];

    return localTab;
}

+(TSTransaction *)localTransactionFromCoreDataTransaction:(TSCDTransaction *)coreDataTransaction
{
    TSTransaction *localTransaction = [[TSTransaction alloc]initWithAmount:coreDataTransaction.amount
                                                                      from:[TSCoreDataBridgingController localUserFromCoreDataUser:coreDataTransaction.source]
                                                                        to:[TSCoreDataBridgingController localUserFromCoreDataUser:coreDataTransaction.destination]
                                                          withCreationDate:coreDataTransaction.created];
    
    return localTransaction;
}

+(TSTabUser *)localUserFromCoreDataUser:(TSCDUser *)coreDataUser
{
    TSTabUser *localUser = [[TSTabUser alloc]initWithEmail:[coreDataUser.email copy]
                                             withFirstName:[coreDataUser.firstName copy]
                                            withMiddleName:[coreDataUser.middleName copy]
                                              withLastName:[coreDataUser.lastName copy]
                                                  userType:coreDataUser.userType];
    
    return localUser;
}

+(TSUserTabSplit *)localSplitFromCoreDataSplit:(TSCDUserTabSplit *)coreDataSplit
{
    TSUserTabSplit *localSplit;
    if([coreDataSplit.userTabType isEqualToNumber:@0])
    {
        localSplit = [[TSUserTabSplit alloc]initWithNormalUser:[TSCoreDataBridgingController localUserFromCoreDataUser:coreDataSplit.user]
                                                        andTab:[TSCoreDataBridgingController localTabFromCoreDataTab:coreDataSplit.tab]
                                                    withAmount:coreDataSplit.amount];
    }
    else
    {
        localSplit = [[TSUserTabSplit alloc]initWithPayerUser:[TSCoreDataBridgingController localUserFromCoreDataUser:coreDataSplit.user]
                                                       andTab:[TSCoreDataBridgingController localTabFromCoreDataTab:coreDataSplit.tab]
                                                   withAmount:coreDataSplit.amount];
    }
    
    return localSplit;
}



@end