//
//  TSContactsManager.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 4/26/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSContactsManager : NSObject

+ (id)sharedManager;
-(NSArray *)phoneContacts;

@end
