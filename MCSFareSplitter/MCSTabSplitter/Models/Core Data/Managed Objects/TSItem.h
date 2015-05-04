//
//  TSItem.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/4/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface TSItem : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSSet *enrolledUsers;
@end

@interface TSItem (CoreDataGeneratedAccessors)

- (void)addEnrolledUsersObject:(NSManagedObject *)value;
- (void)removeEnrolledUsersObject:(NSManagedObject *)value;
- (void)addEnrolledUsers:(NSSet *)values;
- (void)removeEnrolledUsers:(NSSet *)values;

@end
