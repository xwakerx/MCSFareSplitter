//
//  FSUser.h
//  MCSTabSplitter
//
//  Created by MCS on 4/21/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "TSTabUser.h"

@interface TSUser : NSObject

@property (nonatomic, strong) TSTabUser *user;

+(TSUser *)sharedUser;

@end
