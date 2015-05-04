//
//  TSCDAccount.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSCDUser;

@interface TSCDAccount : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) TSCDUser *user;

@end
