//
//  TSCoreDataController.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

static NSString *const kTSFetchInconsistencyException = @"TSFetchInconsistencyException";
static NSString *const kTSFetchInconsistencyExceptionDetail = @"Keys and Values counts must match.";
static NSString *const kTSNilFetchException = @"TSNilFetchException";
static NSString *const kTSNilFetchExceptionDetail = @"Please, check that the names of your attributes and entities match the Core Data Model.";

@interface TSCoreDataManager : NSObject

+ (id)sharedManager;

-(void)saveContext;

-(NSArray *)fetchObjectsFromEntity:(NSString *)entity where:(NSArray *)keys isEqualTo:(NSArray *)values sortedByAttribute:(NSString *)sortAttribute;
-(NSArray *)fetchObjectsFromEntity:(NSString *)entity where:(NSArray *)keys isEqualTo:(NSArray *)values;

-(void)insertObjectWithEntity:(NSString *)entity withInsertionBlock:(BOOL (^)(NSManagedObject *managedObject))insertionBlock;

-(void)updateObjectsFromEntity:(NSString *)entity where:(NSArray *)searchKeys isEqualTo:(NSArray *)searchValues withUpdateBlock:(void(^)(NSManagedObject *managedObject))updateBlock;

-(void)deleteManagedObject:(NSManagedObject *)managedObject;
@end
