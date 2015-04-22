//
//  DataManager.h
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RestClassMapperContentDelegate <NSObject>

@required
- (void) updateComponentWithContent:(id)content;

@end

@interface DataManager : NSObject

@property (nonatomic, strong) id<RestClassMapperContentDelegate> delegate;

+ (id)sharedManager;
- (void)configureRestCall:(NSURL*) baseURL requestString:(NSString*)request forObjectOfType:(id)object;
- (void) getObjectsFromRequest:(NSString*)request;

@end
