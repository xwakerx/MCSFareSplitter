//
//  TSTabController.h
//  MCSTabSplitter
//
//  Created by MCS on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TSTab;
@class TSTabUser;
@class TSUserTabSplit;

@interface TSTabController : NSObject

+(NSArray*) getUserTabs;
+(NSArray*) getUserTabSplittersForTab:(TSTab*)tab withUsers:(NSArray*)users;
+(NSArray*) getPayersTabSplittersForTab:(TSTab*)tab withUsers:(NSArray*)users;

@end
