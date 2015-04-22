//
//  DataManager.m
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (id)sharedManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        //
    }
    return self;
}

- (void)configureRestCall:(NSURL*) baseURL requestString:(NSString*)request forObjectOfType:(id)object
{
//    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
//    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
//    
//    RKObjectMapping *objectMapping = [RKObjectMapping mappingForClass:[object class]];
//    NSArray *propertiesMapper = [ObjectMapper propertiesFor:[object class]];
//    [objectMapping addAttributeMappingsFromArray:propertiesMapper];
//    
//    NSString *lookForInResponse = [ObjectMapper getKeyPathFor:[object class]];
//    
//    RKResponseDescriptor *responseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:objectMapping
//                                                 method:RKRequestMethodGET
//                                            pathPattern:request
//                                                keyPath:lookForInResponse
//                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
//    
//    [objectManager addResponseDescriptor:responseDescriptor];
}

- (void) getObjectsFromRequest:(NSString*)request  {
    id returnObj = nil;
//    [[RKObjectManager sharedManager] getObjectsAtPath:self.requestURL
//       parameters:nil
//          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                if (self.delegate != nil) {
                    [self.delegate updateComponentWithContent:returnObj];
                }
//          }
//          failure:^(RKObjectRequestOperation *operation, NSError *error) {
//              NSLog(@"Something bad happened :| ->  %@", error);
//          }];
    
}


@end
