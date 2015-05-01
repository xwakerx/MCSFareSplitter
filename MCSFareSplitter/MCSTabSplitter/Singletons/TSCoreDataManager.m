//
//  TSCoreDataController.m
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/1/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSCoreDataManager.h"

@interface TSCoreDataManager ()

@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation TSCoreDataManager

+ (id)sharedManager
{
    static TSCoreDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(instancetype)init
{
    if (self = [super init])
    {
        self.appDelegate = [UIApplication sharedApplication].delegate;
    }
    return self;
}

-(void)saveContext
{
    [self.appDelegate saveContext];
}

#pragma mark - FETCH

-(NSArray *)fetchObjectsFromEntity:(NSString *)entity where:(NSArray *)keys isEqualTo:(NSArray *)values
{
    return [self fetchObjectsFromEntity:entity where:keys isEqualTo:values sortedByAttribute:nil];
}

-(NSArray *)fetchObjectsFromEntity:(NSString *)entity where:(NSArray *)keys isEqualTo:(NSArray *)values sortedByAttribute:(NSString *)sortAttribute
{
    if(keys.count != values.count)
    {
        [NSException raise:kTSFetchInconsistencyException format:kTSFetchInconsistencyExceptionDetail];
    }
    NSManagedObjectContext *moc = [self.appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entity inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSMutableString *predicateString = [NSMutableString string];
    
    for (NSInteger i = 0; i < keys.count; i++)
    {
        NSString *key = keys[i];
        NSString *value = values[i];
        
        NSString *predicateSubstring = [NSString stringWithFormat:@"(%@ LIKE[c] '%@')", key, value];
        
        [predicateString appendString:predicateSubstring];
        
        if(i < keys.count - 1)
        {
            [predicateString appendString:@"AND"];
        }
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [request setPredicate:predicate];
    
    if(sortAttribute)
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:sortAttribute ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    if (array == nil)
    {
        [NSException raise:kTSNilFetchException format:kTSNilFetchExceptionDetail];
    }
    
    return array;
}

#pragma mark - INSERT

-(void)insertObjectWithEntity:(NSString *)entity withInsertionBlock:(BOOL (^)(NSManagedObject *managedObject))insertionBlock
{
    [self.appDelegate.undoManager beginUndoGrouping];
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entity
                                                            inManagedObjectContext:self.appDelegate.managedObjectContext];
    if(!managedObject)
    {
        [NSException raise:kTSNilFetchException format:kTSNilFetchExceptionDetail];
    }
    
    if(insertionBlock(managedObject))
    {
        [self.appDelegate.undoManager endUndoGrouping];
        [self.appDelegate saveContext];
    }
    else
    {
        [self.appDelegate.undoManager endUndoGrouping];
        [self.appDelegate.undoManager undo];
    }
}

#pragma mark - UPDATE

-(void)updateObjectsFromEntity:(NSString *)entity where:(NSArray *)searchKeys isEqualTo:(NSArray *)searchValues withUpdateBlock:(void(^)(NSManagedObject *managedObject))updateBlock
{
    NSArray *managedObjects = [self fetchObjectsFromEntity:entity where:searchKeys isEqualTo:searchValues];
    
    for (NSManagedObject *managedObject in managedObjects)
    {
        updateBlock(managedObject);
    }
    
    [self saveContext];
}
#pragma mark - DELETE

-(void)deleteManagedObject:(NSManagedObject *)managedObject
{
    [self.appDelegate.managedObjectContext deleteObject:managedObject];
}

@end