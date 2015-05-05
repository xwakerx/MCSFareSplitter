//
//  TSCDNotification.h
//  MCSTabSplitter
//
//  Created by Manuel Camacho on 5/5/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TSCDNotification : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * amount;
 
@end
